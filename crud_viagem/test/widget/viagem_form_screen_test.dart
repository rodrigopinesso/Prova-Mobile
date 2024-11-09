import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crud_viagem/screens/viagem_form_screen.dart';
import 'package:crud_viagem/services/viagem_service.dart';
import 'package:crud_viagem/models/viagem.dart';
import 'package:mockito/mockito.dart';

class MockViagemService extends Mock implements ViagemService {}

void main() {
  testWidgets('ViagemFormScreen deve salvar nova viagem e voltar para a tela anterior', (WidgetTester tester) async {
    final mockViagemService = MockViagemService();

    await tester.pumpWidget(MaterialApp(
      home: ViagemFormScreen(),
    ));

    expect(find.text('Nova Viagem'), findsOneWidget);
    expect(find.text('Salvar Viagem'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'Viagem para Paris');
    await tester.enterText(find.byType(TextFormField).at(1), 'Paris');
    await tester.enterText(find.byType(TextFormField).at(2), 'Uma descrição da viagem para Paris.');

    await tester.tap(find.text('Salvar Viagem'));
    await tester.pumpAndSettle();

    verify(mockViagemService.addViagem(argThat(isA<Viagem>()))).called(1);
    
    expect(find.text('Nova Viagem'), findsNothing);
  });
}
