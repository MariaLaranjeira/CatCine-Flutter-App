import 'package:catcine_es/Auth/login.dart';
import 'package:catcine_es/Auth/register.dart';
import 'package:flutter/material.dart';


class AuthMainPage extends StatefulWidget {
  const AuthMainPage({Key? key}) : super(key: key);

  @override
  State<AuthMainPage> createState() => _AuthMainPageState();
}

class _AuthMainPageState extends State<AuthMainPage> {

  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(showRegisterPage: toggleScreens);
    } else {
      return RegisterScreen(showLoginPage: toggleScreens);
    }
  }
}
