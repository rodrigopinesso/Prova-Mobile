import 'package:flutter_test/flutter_test.dart';
import 'package:crud_viagem/models/viagem.dart';

void main() {
  group('Viagem', () {
    test('should create an instance from JSON', () {
      final json = {
        'id': '1',
        'nome': 'Viagem a Paris',
        'dataInicio': '2024-11-01T00:00:00.000',
        'dataFim': '2024-11-10T00:00:00.000',
        'destino': 'Paris',
        'descricao': 'Uma viagem incrível a Paris!',
      };

      final viagem = Viagem.fromJson(json);

      expect(viagem.id, '1');
      expect(viagem.nome, 'Viagem a Paris');
      expect(viagem.dataInicio, DateTime.parse('2024-11-01T00:00:00.000'));
      expect(viagem.dataFim, DateTime.parse('2024-11-10T00:00:00.000'));
      expect(viagem.destino, 'Paris');
      expect(viagem.descricao, 'Uma viagem incrível a Paris!');
    });

    test('should convert an instance to JSON', () {
      final viagem = Viagem(
        id: '1',
        nome: 'Viagem a Paris',
        dataInicio: DateTime.parse('2024-11-01T00:00:00.000'),
        dataFim: DateTime.parse('2024-11-10T00:00:00.000'),
        destino: 'Paris',
        descricao: 'Uma viagem incrível a Paris!',
      );

      final json = viagem.toJson();

      expect(json['id'], '1');
      expect(json['nome'], 'Viagem a Paris');
      expect(json['dataInicio'], '2024-11-01T00:00:00.000');
      expect(json['dataFim'], '2024-11-10T00:00:00.000');
      expect(json['destino'], 'Paris');
      expect(json['descricao'], 'Uma viagem incrível a Paris!');
    });
  });
}
