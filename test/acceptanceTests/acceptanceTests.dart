import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:catcine_es/main.dart' as app;

Future<void> main() async {
  enableFlutterDriverExtension();
  runApp(app.MyApp());
}