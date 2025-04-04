import 'package:fitlife/Firebase/Config/config.dart';
import 'package:fitlife/Onboarding/splashScreen.dart';
import 'package:fitlife/SqfLite/intializeSqfLite.dart';
import 'package:flutter/material.dart';

SqfLite? sqflite;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await config();
  sqflite = SqfLite();
  await sqflite!.configSqfLite();
  runApp(MainApp());
}

// ignore: must_be_immutable
class MainApp extends StatelessWidget {
  MainApp({super.key});
  SqfLite? sqfliteObj = sqflite;
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Splashscreen()),
    );
  }
}
