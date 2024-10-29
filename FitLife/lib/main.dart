import 'package:fitness_app/Dashboard/home_ui.dart';
import 'package:fitness_app/Login/login.dart';
import 'package:fitness_app/Onboarding/onboarding.dart';
import 'package:fitness_app/Theme/color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      debugShowCheckedModeBanner: false,
      home: Onbording(),
    );
  }
}
