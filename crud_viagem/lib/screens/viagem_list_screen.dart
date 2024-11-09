import 'package:flutter/material.dart';
import '../models/viagem.dart';
import '../services/viagem_service.dart';
import 'viagem_form_screen.dart';
import 'viagem_detail_screen.dart';
import 'home_screen.dart';

class ViagemListScreen extends StatefulWidget {
  @override
  _ViagemListScreenState createState() => _ViagemListScreenState();
}

class _ViagemListScreenState extends State<ViagemListScreen> {
  final ViagemService _viagemService = ViagemService();
  List<Viagem> _viagens = [];
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _fetchViagens();
  }

  Future<void> _fetchViagens() async {
    try {
      final viagens = await _viagemService.getViagens();
      setState(() {
        _viagens = viagens;
      });
    } catch (e) {
      print('Erro ao buscar viagens: $e');
    }
  }

  Future<void> _deleteViagem(String id) async {
    try {
      await _viagemService.deleteViagem(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Viagem excluída com sucesso')),
      );
      _fetchViagens();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir a viagem: $e')),
      );
    }
  }

  Future<void> _editViagem(Viagem viagem) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViagemFormScreen(viagem: viagem),
      ),
    );
    if (result == true) {
      _fetchViagens();
    }
  }

  void _navigateToForm() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViagemFormScreen()),
    );
    _fetchViagens();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (index == 2) {
      _navigateToForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Minhas Viagens',
          style: TextStyle(
            fontFamily: 'Roboto', 
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white, 
          ),
        ),
        backgroundColor: Colors.orange, 
        elevation: 4,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF5F5F5), 
      body: _viagens.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _viagens.length,
              itemBuilder: (context, index) {
                final viagem = _viagens[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    title: Text(
                      viagem.nome,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    subtitle: Text(
                      viagem.destino,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViagemDetailScreen(viagem: viagem),
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editViagem(viagem),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Confirmar exclusão'),
                                content: Text('Tem certeza de que deseja excluir esta viagem?'),
                                actions: [
                                  TextButton(
                                    child: Text('Cancelar'),
                                    onPressed: () => Navigator.of(context).pop(false),
                                  ),
                                  TextButton(
                                    child: Text('Excluir'),
                                    onPressed: () => Navigator.of(context).pop(true),
                                  ),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              await _deleteViagem(viagem.id);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Viagens',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Adicionar',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
