import 'package:fitlife/Authentication/login.dart';
import 'package:fitlife/Dashboard/editProfile.dart';
import 'package:fitlife/Firebase/Config/config.dart';
import 'package:fitlife/Firebase/Firestore/User/auth.dart';
import 'package:fitlife/Firebase/Storage/fooddata.dart';
import 'package:fitlife/Onboarding/splashScreen.dart';

import 'package:fitlife/SqfLite/intializeSqfLite.dart';
import 'package:fitlife/widget/video_player.dart';
import 'package:flutter/material.dart';
import 'package:fitlife/Dashboard/home_ui.dart';

SqfLite? sqflite;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await config();
  sqflite = SqfLite();
  await sqflite!.configSqfLite();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  SqfLite? sqfliteObj = sqflite;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Splashscreen()),
    );
  }
}
