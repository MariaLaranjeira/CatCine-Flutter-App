import 'package:catcine_es/Auth/authinitial.dart';
import 'package:catcine_es/Auth/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'Auth/login.dart';

import 'package:firebase_core/firebase_core.dart';
import 'Auth/register.dart';
import 'Pages/explore.dart';
import 'Pages/initial.dart';
import 'firebase_options.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HomePage()
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var authentication = FirebaseAuth.instance.currentUser;

  bool connected = false;

  Future<void> checkConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    switch (connectivityResult) {
      case ConnectivityResult.wifi:
        connected = true;
        break;
      case ConnectivityResult.ethernet:
        connected = true;
        break;
      case ConnectivityResult.mobile:
        connected = true;
        break;
      case ConnectivityResult.vpn:
        connected = true;
        break;
      case ConnectivityResult.bluetooth:
        connected = false;
        break;
      case ConnectivityResult.none:
        connected = false;
        break;
      case ConnectivityResult.other:
        connected = false;
        break;
      }
    }

  @override
  Widget build(BuildContext context) {

    while(!connected) {
      checkConnectivity();
      return MaterialApp(
        home: Scaffold(
          body:
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height/(2.1),
                  ),
                  const Text("Loading!"),
                  const SizedBox(
                    height: 25,
                    width: 25,
                    child: LoadingIndicator(indicatorType:  // To use an actual loading Page?
                    Indicator.ballClipRotateMultiple),
                  )

                ],
              ),
            )
        ),
      );
    }

    return const MaterialApp(
        home: InitialScreen()
    );

  }
}

