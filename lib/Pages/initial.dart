import 'package:catcine_es/Pages/explore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {

  void _signIn() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void _register() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff393d5a),
      appBar: AppBar(
        backgroundColor: Color(0xff393d5a), // not sure o que é isto
        elevation: 0.0,
      ),
      body: Padding (
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('images/Initial.png'),
              Container(
                width:double.infinity,
                child: RawMaterialButton(
                  fillColor: Color(0xFFEC6B76),
                  elevation: 0.0,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  onPressed: _signIn,
                  child: Text(
                      "Sign in" ,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              SizedBox( height: 34.0),
              Container(
                width:double.infinity,
                child: RawMaterialButton(
                  fillColor: Color(0xBDD3D4FF),
                  elevation: 0.0,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  onPressed: _register,
                  child: Text(
                    "Register" ,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}

