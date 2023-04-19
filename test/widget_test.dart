// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:catcine_es/Auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';


void main() {

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });

  late LoginScreen kevavs;

  /*
  testWidgets('Pipi', (WidgetTester tester) async {
    assert(await tester.pumpWidget(const MyApp()),true);
  });
  */
  test("kevavs", () async{
    String expectedString = "";
    User? user;
    try {
      var aux = await FirebaseAuth.instance.signInWithEmailAndPassword(email: 'test@test.com', password: 'testing');
      user = aux.user;
    } on FirebaseAuthException catch (exception) {
      if (exception.code == "user-not-found") {
        expectedString = "User not found for this email";
      }
    }
    expect(expectedString,"User not found for this email" );
  });

  tearDownAll(() async {
    await Firebase.app().delete();
  });

}
