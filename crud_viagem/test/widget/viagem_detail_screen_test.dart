import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crud_viagem/screens/viagem_detail_screen.dart';
import 'package:crud_viagem/models/viagem.dart';
import 'package:crud_viagem/screens/entrada_diario_list_screen.dart';

void main() {
  testWidgets('ViagemDetailScreen exibe detalhes da viagem e navega para EntradaDiarioListScreen', (WidgetTester tester) async {
    final viagem = Viagem(id: '1', nome: 'Viagem para Paris', destino: 'Paris', descricao: 'Uma viagem maravilhosa para Paris.');

    await tester.pumpWidget(MaterialApp(
      home: ViagemDetailScreen(viagem: viagem),
    ));

    expect(find.text('Destino: Paris'), findsOneWidget);
    expect(find.text('Descrição: Uma viagem maravilhosa para Paris.'), findsOneWidget);
    expect(find.text('Ver entradas do diário'), findsOneWidget);

    await tester.tap(find.text('Ver entradas do diário'));
    await tester.pumpAndSettle();

    expect(find.byType(EntradaDiarioListScreen), findsOneWidget);
  });
}
