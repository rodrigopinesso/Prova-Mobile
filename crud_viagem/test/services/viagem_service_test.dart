// test/viagem_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:crud_viagem/services/viagem_service.dart';
import 'package:crud_viagem/models/viagem.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('ViagemService', () {
    late ViagemService viagemService;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      viagemService = ViagemService(client: mockClient);
    });

    test('Deve retornar uma lista de viagens quando o servidor responder com sucesso', () async {
      when(mockClient.get(Uri.parse('http://localhost:3000/viagens')))
          .thenAnswer((_) async => http.Response(
                '[{"id": "1", "nome": "Viagem para Paris", "dataInicio": "2024-01-01", "dataFim": "2024-01-15"}]',
                200,
              ));

      final viagens = await viagemService.getViagens();
      expect(viagens, isA<List<Viagem>>());
      expect(viagens.length, 1);
      expect(viagens[0].nome, 'Viagem para Paris');
    });

    test('Deve lançar exceção quando o servidor retornar erro', () async {
      when(mockClient.get(Uri.parse('http://localhost:3000/viagens')))
          .thenAnswer((_) async => http.Response('Erro', 500));

      expect(() async => await viagemService.getViagens(), throwsException);
    });
  });
}
