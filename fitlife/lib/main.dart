import 'package:firebase_core/firebase_core.dart';
import 'package:fitlife/Authentication/login.dart';
import 'package:fitlife/Authentication/onboarding.dart';
import 'package:fitlife/Authentication/signUp.dart';
import 'package:fitlife/Dashboard/home_ui.dart';
import 'package:fitlife/Firebase/Config/config.dart';
import 'package:fitlife/Firebase/Storage/fooddata.dart';
import 'package:fitlife/Meal_Planner/mealHome.dart';
import 'package:fitlife/Meal_Planner/mealSchedule.dart';
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
        body: Mealhome(),
      ),
    );
  }
}
