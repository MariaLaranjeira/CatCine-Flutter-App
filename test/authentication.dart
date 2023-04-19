import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final instance = MockFirebaseAuth();

  test("Testing User Creation and Authentication", () async {
    User? user = MockUser();

    String email = 'test@testing.com';
    String password = 'testing';

    instance.createUserWithEmailAndPassword(email: 'test@testing.com', password: 'testing');
    var userCredential = await instance.signInWithEmailAndPassword(email: email, password: password);
    user = userCredential.user;
    expect(user!.email,equals('test@testing.com'));
  });


  test("Testing Other Stuff Purrr", () async {

    String email = 'test@testing.com';
    String password = 't';

    try {
      instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (exception) {
      print ("testing... hello?");
      expect(exception.message,equals("weak-password"));
    }
  });

}