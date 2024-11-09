import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/viagem_service.dart';
import '../models/entrada_diario.dart';
import 'entrada_diario_form_screen.dart';

class EntradaDiarioListScreen extends StatefulWidget {
  final String viagemId;

  EntradaDiarioListScreen({required this.viagemId});

  @override
  _EntradaDiarioListScreenState createState() =>
      _EntradaDiarioListScreenState();
}

class _EntradaDiarioListScreenState extends State<EntradaDiarioListScreen> {
  late Future<List<EntradaDiario>> entradasDiario;
  List<EntradaDiario> todasEntradas = [];
  List<EntradaDiario> entradasFiltradas = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterEntries);
    entradasDiario = _fetchEntradasDiario();
  }

  Future<List<EntradaDiario>> _fetchEntradasDiario() async {
    try {
      List<EntradaDiario> entradas = await ViagemService().getEntradasPorViagem(widget.viagemId);
      setState(() {
        todasEntradas = entradas;
        entradasFiltradas = entradas;
      });
      return entradas;
    } catch (e) {
      print('Erro ao carregar entradas de diário: $e');
      return [];
    }
  }

  void _filterEntries() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      entradasFiltradas = todasEntradas.where((entrada) {
        return entrada.titulo.toLowerCase().contains(query);
      }).toList();
    });
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entradas de Diário'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EntradaDiarioFormScreen(viagemId: widget.viagemId),
                ),
              ).then((_) => setState(() {
                    entradasDiario = _fetchEntradasDiario();
                  }));
            },
            color: Colors.white,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Pesquisar por título',
                prefixIcon: Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<EntradaDiario>>(
              future: entradasDiario,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro ao carregar entradas de diário.'));
                } else if (!snapshot.hasData || entradasFiltradas.isEmpty) {
                  return Center(child: Text('Nenhuma entrada de diário encontrada.'));
                } else {
                  return ListView.builder(
                    itemCount: entradasFiltradas.length,
                    itemBuilder: (context, index) {
                      EntradaDiario entrada = entradasFiltradas[index];
                      return Dismissible(
                        key: ValueKey(entrada.id),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            entradasFiltradas.removeAt(index);
                            todasEntradas.removeWhere((e) => e.id == entrada.id);
                          });
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        child: Card(
                          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entrada.titulo,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Data: ${_formatDate(entrada.data)}',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  entrada.conteudo.length > 100
                                      ? '${entrada.conteudo.substring(0, 100)}...'
                                      : entrada.conteudo,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
