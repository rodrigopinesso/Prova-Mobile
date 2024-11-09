import 'package:flutter/material.dart';
import '../models/viagem.dart';
import '../services/viagem_service.dart';

class ViagemFormScreen extends StatefulWidget {
  final Viagem? viagem;

  ViagemFormScreen({this.viagem});

  @override
  _ViagemFormScreenState createState() => _ViagemFormScreenState();
}

class _ViagemFormScreenState extends State<ViagemFormScreen> {
  final ViagemService _viagemService = ViagemService();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _destinoController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  int _currentIndex = 2; 

  @override
  void initState() {
    super.initState();
    if (widget.viagem != null) {
      _nomeController.text = widget.viagem!.nome;
      _destinoController.text = widget.viagem!.destino;
      _descricaoController.text = widget.viagem!.descricao;
    }
  }

  void _submitForm() async {
    if (_nomeController.text.isEmpty ||
        _destinoController.text.isEmpty ||
        _descricaoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos obrigatórios')),
      );
      return;
    }

    final viagem = Viagem(
      id: widget.viagem?.id ?? DateTime.now().toString(),
      nome: _nomeController.text,
      destino: _destinoController.text,
      descricao: _descricaoController.text,
      dataInicio: widget.viagem?.dataInicio ?? DateTime.now(),
      dataFim: widget.viagem?.dataFim ?? DateTime.now(),
    );

    try {
      if (widget.viagem == null) {
        await _viagemService.addViagem(viagem);
      } else {
        await _viagemService.updateViagem(viagem);
      }
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar a viagem: $e')),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/viagens');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/nova-viagem');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.viagem == null ? 'Nova Viagem' : 'Editar Viagem',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
        elevation: 4,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                controller: _nomeController,
                label: 'Nome da Viagem',
                hint: 'Digite o nome da viagem',
              ),
              SizedBox(height: 12),
              _buildTextField(
                controller: _destinoController,
                label: 'Destino',
                hint: 'Digite o destino da viagem',
              ),
              SizedBox(height: 12),
              _buildTextField(
                controller: _descricaoController,
                label: 'Descrição',
                hint: 'Digite uma descrição sobre a viagem',
                maxLines: 4,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  widget.viagem == null ? 'Salvar Viagem' : 'Atualizar Viagem',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
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
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 4,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(color: Colors.blueAccent),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
}
