import 'dart:convert';
import 'package:http/http.dart' as http;
import '../screens/entrada_diario_form_screen.dart';
import '../models/entrada_diario.dart';

class EntradaDiarioService {
  final String baseUrl = 'http://localhost:3000';

  Future<void> addEntradaDiario(EntradaDiario entrada) async {
    final response = await http.post(
      Uri.parse('$baseUrl/entradasDiario'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(entrada.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Erro ao adicionar entrada de diário');
    }
  }
}
