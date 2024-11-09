import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/viagem_list_screen.dart';
import 'screens/viagem_form_screen.dart';
import 'screens/entrada_diario_form_screen.dart'; // Importe a tela de formulário

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diário de Viagem',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home', // Rota inicial do aplicativo
      routes: {
        '/home': (context) => HomeScreen(),
        '/viagens': (context) => ViagemListScreen(),
        '/nova-viagem': (context) => ViagemFormScreen(),
      },
      onGenerateRoute: (settings) {
        // Quando a rota for '/entrada_diario_form', forneça o parâmetro 'viagemId'
        if (settings.name == '/entrada_diario_form') {
          final String viagemId = settings.arguments as String; // Pegue o parâmetro 'viagemId'
          return MaterialPageRoute(
            builder: (context) => EntradaDiarioFormScreen(viagemId: viagemId),
          );
        }
        return null; // Retorna null se a rota não for reconhecida
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
