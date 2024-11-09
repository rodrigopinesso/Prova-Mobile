import 'package:flutter/material.dart';
import '../services/entrada_diario_service.dart';
import '../models/entrada_diario.dart';

class EntradaDiarioFormScreen extends StatefulWidget {
  final String viagemId;

  const EntradaDiarioFormScreen({Key? key, required this.viagemId}) : super(key: key);

  @override
  _EntradaDiarioFormScreenState createState() => _EntradaDiarioFormScreenState();
}

class _EntradaDiarioFormScreenState extends State<EntradaDiarioFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _conteudoController = TextEditingController();
  DateTime? _dataSelecionada;

  final EntradaDiarioService _entradaDiarioService = EntradaDiarioService();

  void _salvarEntradaDiario() async {
    if (_formKey.currentState!.validate()) {
      final titulo = _tituloController.text;
      final conteudo = _conteudoController.text;

      final novaEntrada = EntradaDiario(
        id: DateTime.now().toString(),
        titulo: titulo,
        data: _dataSelecionada ?? DateTime.now(),
        conteudo: conteudo,
        viagemId: widget.viagemId,
      );

      try {
        await _entradaDiarioService.addEntradaDiario(novaEntrada);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Entrada de Diário salva com sucesso!')),
        );

        Navigator.pop(context, novaEntrada); 
      } catch (e, stackTrace) {
        print('Erro ao salvar entrada: $e');
        print('Stack Trace: $stackTrace');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar entrada: $e')),
        );
      }
    }
  }

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _dataSelecionada) {
      setState(() {
        _dataSelecionada = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Entrada de Diário'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o título';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              TextFormField(
                readOnly: true,
                onTap: () => _selecionarData(context),
                decoration: InputDecoration(
                  labelText: 'Data',
                  hintText: _dataSelecionada != null
                      ? '${_dataSelecionada!.day}/${_dataSelecionada!.month}/${_dataSelecionada!.year}'
                      : 'Selecione uma data',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (_dataSelecionada == null) {
                    return 'Por favor, selecione uma data';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: _conteudoController,
                decoration: InputDecoration(
                  labelText: 'Conteúdo',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o conteúdo';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: _salvarEntradaDiario,
                child: Text('Salvar Entrada', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
