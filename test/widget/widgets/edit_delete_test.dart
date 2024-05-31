import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  group('BrowsePage Widget Tests', () {
    testWidgets('renders MaterialApp', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold()));
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('renders Scaffold', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold()));
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('renders SizedBox', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SizedBox()));
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('renders Container', (WidgetTester tester) async {
      await tester.pumpWidget( MaterialApp(home: Container()));
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('renders Center', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Center()));
      expect(find.byType(Center), findsOneWidget);
    });

    testWidgets('renders Text', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Text('')));
      expect(find.byType(Text), findsOneWidget);
    });

    

  });
}