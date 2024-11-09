import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/screens/entrada_diario_form_screen.dart';  
import 'package:myapp/services/entrada_diario_service.dart';     
import 'package:myapp/models/entrada_diario.dart';

class MockEntradaDiarioService extends Mock implements EntradaDiarioService {}

void main() {
  group('EntradaDiarioFormScreen', () {
    late MockEntradaDiarioService mockService;

    setUp(() {
      mockService = MockEntradaDiarioService();
    });

    testWidgets('Deve salvar a entrada de diário quando o formulário for válido', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: EntradaDiarioFormScreen(viagemId: '123'),
        ),
      );

      await tester.enterText(find.byType(TextFormField).at(0), 'Título de Teste');
      await tester.enterText(find.byType(TextFormField).at(2), 'Conteúdo do diário');
      await tester.tap(find.byType(TextFormField).at(1)); 
      await tester.pumpAndSettle();

      await tester.tap(find.text('Salvar Entrada'));
      await tester.pump();

      verify(mockService.addEntradaDiario(any)).called(1);

      expect(find.text('Entrada de Diário salva com sucesso!'), findsOneWidget);
    });

    testWidgets('Deve mostrar um erro quando falhar ao salvar', (WidgetTester tester) async {
      when(mockService.addEntradaDiario(any)).thenThrow(Exception('Erro ao salvar'));

      await tester.pumpWidget(
        MaterialApp(
          home: EntradaDiarioFormScreen(viagemId: '123'),
        ),
      );

      await tester.enterText(find.byType(TextFormField).at(0), 'Título de Teste');
      await tester.enterText(find.byType(TextFormField).at(2), 'Conteúdo do diário');
      await tester.tap(find.byType(TextFormField).at(1)); 
      await tester.pumpAndSettle();

      await tester.tap(find.text('Salvar Entrada'));
      await tester.pump();

      expect(find.text('Erro ao salvar entrada: Exception: Erro ao salvar'), findsOneWidget);
    });
  });
}
