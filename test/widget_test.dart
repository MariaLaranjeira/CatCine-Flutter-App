import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:catcine_es/main.dart';

void main() {
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  tearDownAll(() async {
    await Firebase.app().delete();
  });

  testWidgets('MyApp launches without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
  });
}
