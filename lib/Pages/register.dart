import 'package:catcine_es/Pages/explore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>{
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
              Text(
                "Create Account",
                style:
                TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 44.0,
              ),
              TextField(
                decoration: InputDecoration(
                  filled:true,
                  fillColor: Color(0xFFFFFFFF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Enter your catname",
                ),
              ),
              SizedBox(
                height: 26.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  filled:true,
                  fillColor: Color(0xFFFFFFFF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Enter your email",
                ),
              ),
              SizedBox(
                height: 26.0,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  filled:true,
                  fillColor: Color(0xFFFFFFFF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Enter your password",
                ),
              ),
              SizedBox(
                height: 26.0,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  filled:true,
                  fillColor: Color(0xFFFFFFFF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Confirm your password",
                ),
              ),
              SizedBox(
                height: 34.0,
              ),
              Container(
                width:double.infinity,
                child: RawMaterialButton(
                  fillColor: Color(0xFFEC6B76),
                  elevation: 0.0,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  onPressed: () {},
                  child: Text("Register" , style: TextStyle(color: Colors.white, fontSize: 18.0)),
                ),
              ),
            ],
          )
      ),
    );
  }
}