import 'package:flutter/material.dart';
import '../models/viagem.dart';
import 'entrada_diario_list_screen.dart';
import 'home_screen.dart';
import 'viagem_list_screen.dart';
import 'viagem_form_screen.dart';

class ViagemDetailScreen extends StatefulWidget {
  final Viagem viagem;

  ViagemDetailScreen({required this.viagem});

  @override
  _ViagemDetailScreenState createState() => _ViagemDetailScreenState();
}

class _ViagemDetailScreenState extends State<ViagemDetailScreen> {
  int _selectedIndex = 0; 

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ViagemListScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ViagemFormScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.viagem.nome,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.orange, 
        elevation: 4,
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFF5F5F5), 
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Destino:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12.0), 
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ], 
              ),
              child: TextField(
                controller: TextEditingController(text: widget.viagem.destino),
                readOnly: true,
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Descrição:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ], 
              ),
              child: TextField(
                controller: TextEditingController(text: widget.viagem.descricao),
                readOnly: true,
                style: TextStyle(fontSize: 16),
                maxLines: 4,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EntradaDiarioListScreen(viagemId: widget.viagem.id),
                  ),
                );
              },
              child: Text('Ver entradas do diário'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, 
                padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), 
                ),
                elevation: 8, 
                shadowColor: Colors.black26, 
                foregroundColor: Colors.white, 
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
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
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
        elevation: 8,
      ),
    );
  }
}
