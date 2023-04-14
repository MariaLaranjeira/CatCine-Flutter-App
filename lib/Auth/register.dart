import 'package:catcine_es/Auth/authinitial.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterScreen({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future signUp(String email, String password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xff393d5a),
      appBar: AppBar(
        backgroundColor: const Color(0xff393d5a), // not sure o que é isto
        elevation: 0.0,
      ),
      body: Padding (
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Create",
                  style:
                  TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Account",
                  style:
                  TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 44.0),

                TextField(
                  decoration: InputDecoration(
                    filled:true,
                    fillColor: const Color(0xFFFFFFFF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: " Enter your catname",
                  ),
                ),

                const SizedBox(height: 26.0),

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
                const SizedBox(height: 26.0),

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

                const SizedBox(height: 26.0),

                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled:true,
                    fillColor: const Color(0xFFFFFFFF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: " Confirm your password",
                  ),
                ),
                const SizedBox(height: 34.0),

                SizedBox(
                  width:double.infinity,
                  child: RawMaterialButton(
                    fillColor: const Color(0xFFEC6B76),
                    elevation: 0.0,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: () {
                      if (passwordController.text.trim() == confirmPasswordController.text.trim()) {
                        signUp(emailController.text.trim(), passwordController.text.trim());
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const MainPage()
                            )
                        );
                      }
                    },
                    child: const Text(
                        "Register" ,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("I'm already a user!",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                        onTap: widget.showLoginPage,
                        child: const Text(
                            "Login Now",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                        )
                    )
                  ],
                )
              ],
            ),
          )
      ),
    );
  }
}