import 'package:catcine_es/Auth/authmain.dart';
import 'package:catcine_es/main.dart';
import 'package:flutter/material.dart';


class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {

  _signIn() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AuthMainPage(pageSelector: true)
      ));
  }

  _register() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AuthMainPage(pageSelector: false)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff393d5a),
      body: Container (
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
              alignment: Alignment(0.2,-0.37),
              image: AssetImage('images/Initial.png'),
              fit: BoxFit.contain,
            )
        ),
        child: Padding (
          padding: EdgeInsets.symmetric(horizontal: width/25.71),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height/1.4),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children:[
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
                  Positioned(
                    top: -43,
                    child: Image(
                      image: const AssetImage("images/Small_cat.png"),
                      width: width/5,),
                  ),
                ]
              ),
              SizedBox(height: height/25),

              SizedBox(
                width:double.infinity,
                child: RawMaterialButton(
                  key: const Key("registerButton"),
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

