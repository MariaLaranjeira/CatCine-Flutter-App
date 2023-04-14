
import 'package:catcine_es/Pages/explore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (exception) {
      if (exception.code == "user-not-found") {
        print("User not found for this email");
      }
    }

    return user;
  }

  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xff393d5a),
      appBar: AppBar(
        backgroundColor: const Color(0xff393d5a), // not sure o que é isto
        elevation: 0.0,
      ),
      body: Padding (
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome",
                style:
                TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Back",
                style:
                TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 44.0),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  filled:true,
                  fillColor: const Color(0xFFFFFFFF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: " Enter your email",
                ),
              ),
              const SizedBox( height: 26.0),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  filled:true,
                  fillColor: const Color(0xFFFFFFFF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: " Enter your password",
                ),
              ),
              const SizedBox( height: 26.0),

              SizedBox(
                width:double.infinity,
                child: RawMaterialButton(
                  fillColor: const Color(0xFFEC6B76),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  onPressed: () async {
                    User? user = await loginUsingEmailPassword(email: emailController.text, password: passwordController.text, context: context);
                    print(user);
                    if (user != null) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ExploreFilm()));
                    }
                    else {

                    }
                  },
                  child: const Text(
                      "Sign in" ,
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
