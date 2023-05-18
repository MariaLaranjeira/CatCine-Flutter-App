import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Auth/authinitial.dart';
import 'Model/media.dart';

Map<String, Media> allLocalMedia = {};

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home:const HomePage()
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var isDialogOpen = false;

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException {
      print('Couldn\'t check connectivity status');
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_connectionStatus == ConnectivityResult.wifi
          || _connectionStatus == ConnectivityResult.mobile
          || _connectionStatus == ConnectivityResult.ethernet
          || _connectionStatus == ConnectivityResult.vpn) {
        print('Has Connection');
        if (isDialogOpen) {
          Navigator.of(context, rootNavigator: true).pop();
          isDialogOpen = false;
        }
      } else {
        Navigator.of(context).push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
              isDialogOpen = true;
              return Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height/15,),
                  AlertDialog(
                      alignment: Alignment.topCenter,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      backgroundColor: const Color.fromARGB(255, 255, 87, 51),
                      content:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "No Internet Connection!",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              );
            }
          )
        );
      }
    });
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return const MainPage();
  }
}

