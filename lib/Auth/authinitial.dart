import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Pages/homePage.dart';
import '../Pages/initial.dart';


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Home();
          } else {
            return const InitialScreen();
          }
        },
      ),
    );
  }
}
