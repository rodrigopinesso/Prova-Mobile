import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crud_viagem/screens/home_screen.dart';
import 'package:crud_viagem/screens/viagem_list_screen.dart';
import 'package:crud_viagem/screens/viagem_form_screen.dart';

void main() {
  testWidgets('HomeScreen possui botões para navegação', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: HomeScreen(),
    ));

    expect(find.text('Minhas Viagens'), findsOneWidget);
    expect(find.text('Adicionar Nova Viagem'), findsOneWidget);
    expect(find.byIcon(Icons.list), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(find.text('Minhas Viagens'));
    await tester.pumpAndSettle();
    expect(find.byType(ViagemListScreen), findsOneWidget);

    await tester.tap(find.text('Adicionar Nova Viagem'));
    await tester.pumpAndSettle();
    expect(find.byType(ViagemFormScreen), findsOneWidget);
  });
}
