import 'package:catcine_es/Auth/login.dart';
import 'package:catcine_es/Auth/register.dart';
import 'package:flutter/material.dart';


class AuthMainPage extends StatefulWidget {

  final bool pageSelector;
  const AuthMainPage({Key? key, required this.pageSelector}) : super(key: key);

  @override
  State<AuthMainPage> createState() => _AuthMainPageState();
}

class _AuthMainPageState extends State<AuthMainPage> {
  late bool showLoginPage = widget.pageSelector;

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
