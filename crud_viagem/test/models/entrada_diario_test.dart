import 'package:flutter_test/flutter_test.dart';
import 'package:crud_viagem/models/entrada_diario.dart';

void main() {
  group('EntradaDiario', () {
    test('should create an instance from JSON', () {
      final json = {
        'id': '1',
        'titulo': 'Meu primeiro diário',
        'data': '2024-11-05T00:00:00.000',
        'conteudo': 'Conteúdo do diário',
        'viagemId': 'viagem123',
      };

      final entradaDiario = EntradaDiario.fromJson(json);

      expect(entradaDiario.id, '1');
      expect(entradaDiario.titulo, 'Meu primeiro diário');
      expect(entradaDiario.data, DateTime.parse('2024-11-05T00:00:00.000'));
      expect(entradaDiario.conteudo, 'Conteúdo do diário');
      expect(entradaDiario.viagemId, 'viagem123');
    });

    test('should convert an instance to JSON', () {
      final entradaDiario = EntradaDiario(
        id: '1',
        titulo: 'Meu primeiro diário',
        data: DateTime.parse('2024-11-05T00:00:00.000'),
        conteudo: 'Conteúdo do diário',
        viagemId: 'viagem123',
      );

      final json = entradaDiario.toJson();

      expect(json['id'], '1');
      expect(json['titulo'], 'Meu primeiro diário');
      expect(json['data'], '2024-11-05T00:00:00.000');
      expect(json['conteudo'], 'Conteúdo do diário');
      expect(json['viagemId'], 'viagem123');
    });
  });
}
