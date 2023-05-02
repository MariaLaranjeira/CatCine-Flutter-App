import 'package:catcine_es/Auth/authinitial.dart';
import 'package:catcine_es/Auth/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RegisterScreen widget', () {
    testWidgets('renders RegisterScreen widget', (WidgetTester tester) async {
      await tester.pumpWidget(
          MaterialApp(home: RegisterScreen(showLoginPage: () {})));
      expect(find.byType(RegisterScreen), findsOneWidget);
    });
  });
}