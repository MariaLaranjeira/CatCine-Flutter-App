import 'package:catcine_es/Auth/authmain.dart';
import 'package:catcine_es/main.dart';
import 'package:flutter/material.dart';
import 'package:catcine_es/api.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {

  void _signIn() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AuthMainPage(pageSelector: true)
      ));
  }

  void _register() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AuthMainPage(pageSelector: false)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff393d5a),
      body: Container (
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/Initial.png'),
              fit: BoxFit.contain,
            )
        ),
        child: Padding (
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 560.0),
              SizedBox(
                key: const Key('Sign In'),
                width:double.infinity,
                child: RawMaterialButton(
                  key: const Key("signInButton"),
                  fillColor: const Color(0xFFEC6B76),
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  onPressed: _signIn,
                  child: const Text(
                    "Sign In" ,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 25.0),

              SizedBox(
                width:double.infinity,
                child: RawMaterialButton(
                  fillColor: const Color(0xBDD3D4FF),
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  onPressed: _register,
                  child: const Text(
                    "Register" ,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

