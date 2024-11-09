import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crud_viagem/screens/entrada_diario_list_screen.dart';
import 'package:crud_viagem/screens/entrada_diario_from_screen.dart';
import 'package:crud_viagem/models/entrada_diario.dart';
import 'package:crud_viagem/services/viagem_service.dart';
import 'package:mockito/mockito.dart';

class MockViagemService extends Mock implements ViagemService {}

void main() {
  group('EntradaDiarioListScreen', () {
    testWidgets('exibe uma lista de entradas e navega para o formulário', (WidgetTester tester) async {
      final mockViagemService = MockViagemService();

      when(mockViagemService.getEntradasPorViagem('123'))
          .thenAnswer((_) async => [
                EntradaDiario(titulo: 'Entrada 1', conteudo: 'Conteúdo 1'),
                EntradaDiario(titulo: 'Entrada 2', conteudo: 'Conteúdo 2'),
              ]);

      await tester.pumpWidget(MaterialApp(
        home: EntradaDiarioListScreen(viagemId: '123'),
      ));

      await tester.pumpAndSettle();

      expect(find.text('Entrada 1'), findsOneWidget);
      expect(find.text('Conteúdo 1'), findsOneWidget);
      expect(find.text('Entrada 2'), findsOneWidget);
      expect(find.text('Conteúdo 2'), findsOneWidget);

      expect(find.byType(FloatingActionButton), findsOneWidget);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byType(EntradaDiarioFormScreen), findsOneWidget);

      await tester.tap(find.byIcon(Icons.check));
      await tester.pumpAndSettle();

      expect(find.text('Entrada 1'), findsOneWidget);
      expect(find.text('Conteúdo 1'), findsOneWidget);
      expect(find.text('Entrada 2'), findsOneWidget);
      expect(find.text('Conteúdo 2'), findsOneWidget);
    });
  });
}
