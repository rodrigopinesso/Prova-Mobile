// lib/services/viagem_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/viagem.dart';
import '../models/entrada_diario.dart';

class ViagemService {
  final String baseUrl = 'http://localhost:3000';
  final http.Client client;

  ViagemService({http.Client? client})
      : client = client ?? http.Client();

  Future<List<Viagem>> getViagens() async {
    final response = await client.get(Uri.parse('$baseUrl/viagens'));
    if (response.statusCode == 200) {
      final List<dynamic> viagemJson = jsonDecode(response.body);
      return viagemJson.map((json) => Viagem.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar viagens');
    }
  }

  Future<void> addViagem(Viagem viagem) async {
    final response = await client.post(
      Uri.parse('$baseUrl/viagens'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(viagem.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Erro ao adicionar viagem');
    }
  }

  Future<void> updateViagem(Viagem viagem) async {
    final response = await client.put(
      Uri.parse('$baseUrl/viagens/${viagem.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(viagem.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar viagem');
    }
  }

  Future<void> deleteViagem(String id) async {
    final response = await client.delete(Uri.parse('$baseUrl/viagens/$id'));
    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar viagem');
    }
  }

  Future<List<EntradaDiario>> getEntradasPorViagem(String viagemId) async {
    final response = await client.get(Uri.parse('$baseUrl/entradasDiario?viagemId=$viagemId'));
    if (response.statusCode == 200) {
      final List<dynamic> entradaJson = jsonDecode(response.body);
      return entradaJson.map((json) => EntradaDiario.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar entradas de diário');
    }
  }

  Future<void> addEntradaDiario(EntradaDiario entrada) async {
    final response = await client.post(
      Uri.parse('$baseUrl/entradasDiario'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(entrada.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Erro ao adicionar entrada de diário');
    }
  }

  Future<void> deleteEntradaDiario(String id) async {
    final response = await client.delete(Uri.parse('$baseUrl/entradasDiario/$id'));
    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar entrada de diário');
    }
  }


  Future<void> updateEntradaDiario(EntradaDiario entrada) async {
    final response = await client.put(
      Uri.parse('$baseUrl/entradasDiario/${entrada.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(entrada.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar entrada de diário');
    }
  }
}