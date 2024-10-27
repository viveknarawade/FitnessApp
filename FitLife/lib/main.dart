import 'package:fitness_app/Dashboard/home_ui.dart';
import 'package:fitness_app/Meal_Planner/mealCategory.dart';
import 'package:fitness_app/workout/workoutLineChart.dart';
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
      home:HomeUi(),
    );
  }
}
