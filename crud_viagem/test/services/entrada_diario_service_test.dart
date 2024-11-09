import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'dart:convert';
import 'package:myapp/services/entrada_diario_service.dart';
import 'package:myapp/models/entrada_diario.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('EntradaDiarioService', () {
    late EntradaDiarioService entradaDiarioService;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      entradaDiarioService = EntradaDiarioService(httpClient: mockHttpClient);
    });

    test('Deve salvar uma entrada de diário com sucesso', () async {
      final novaEntrada = EntradaDiario(
        id: '1',
        titulo: 'Título Teste',
        conteudo: 'Conteúdo Teste',
        data: DateTime.now(),
        viagemId: '123',
      );

      when(mockHttpClient.post(
        Uri.parse('https://sua-api.com/api/entradas'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('{"id": "1"}', 200));

      await entradaDiarioService.addEntradaDiario(novaEntrada);

      verify(mockHttpClient.post(
        Uri.parse('https://sua-api.com/api/entradas'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'titulo': novaEntrada.titulo,
          'conteudo': novaEntrada.conteudo,
          'data': novaEntrada.data.toIso8601String(),
          'viagemId': novaEntrada.viagemId,
        }),
      )).called(1);
    });

    test('Deve lançar uma exceção quando a requisição falhar', () async {
      final novaEntrada = EntradaDiario(
        id: '1',
        titulo: 'Título Teste',
        conteudo: 'Conteúdo Teste',
        data: DateTime.now(),
        viagemId: '123',
      );

      when(mockHttpClient.post(
        Uri.parse('https://sua-api.com/api/entradas'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenThrow(Exception('Erro de conexão'));

      expect(() async => await entradaDiarioService.addEntradaDiario(novaEntrada),
          throwsException);
    });
  });
}
