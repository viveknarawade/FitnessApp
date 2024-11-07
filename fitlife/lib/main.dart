import 'package:firebase_core/firebase_core.dart';
import 'package:fitlife/Authentication/onboarding.dart';
import 'package:fitlife/Firebase/Config/config.dart';
import 'package:flutter/material.dart';

void main() async {
 await config();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Onbording(),
      ),
    );
  }
}
