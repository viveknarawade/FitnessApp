import 'package:fitness_app/meal/mealCategory.dart';
import 'package:fitness_app/profile.dart';
import 'package:flutter/material.dart';
import './workout/workoutTracker.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Profile(),
    );
  }
}
