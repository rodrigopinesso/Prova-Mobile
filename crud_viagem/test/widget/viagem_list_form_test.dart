import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crud_viagem/screens/viagem_list_screen.dart';
import 'package:crud_viagem/services/viagem_service.dart';
import 'package:crud_viagem/models/viagem.dart';
import 'package:mockito/mockito.dart';

class MockViagemService extends Mock implements ViagemService {}

void main() {
  testWidgets('ViagemListScreen deve exibir lista de viagens e permitir exclusão', (WidgetTester tester) async {
    final mockViagemService = MockViagemService();

    when(mockViagemService.getViagens()).thenAnswer((_) async => [
      Viagem(id: '1', nome: 'Viagem para Paris', destino: 'Paris', descricao: 'Uma descrição', dataInicio: DateTime.now(), dataFim: DateTime.now()),
      Viagem(id: '2', nome: 'Viagem para Londres', destino: 'Londres', descricao: 'Uma descrição', dataInicio: DateTime.now(), dataFim: DateTime.now()),
    ]);

    await tester.pumpWidget(MaterialApp(
      home: ViagemListScreen(),
    ));

    await tester.pumpAndSettle();

    expect(find.text('Viagem para Paris'), findsOneWidget);
    expect(find.text('Viagem para Londres'), findsOneWidget);

    when(mockViagemService.deleteViagem('1')).thenAnswer((_) async {});

    await tester.tap(find.byIcon(Icons.delete).first);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Excluir'));
    await tester.pumpAndSettle();

    expect(find.text('Viagem para Paris'), findsNothing);
  });
}
