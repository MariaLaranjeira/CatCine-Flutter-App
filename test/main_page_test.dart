import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catcine_es/main.dart';

void main() {
  group('MyApp', () {
    testWidgets('Renders MyStatefulWidget as home',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
