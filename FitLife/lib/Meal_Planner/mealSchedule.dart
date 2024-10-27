import 'package:fitness_app/Meal_Planner/breakfast.dart';
import 'package:fitness_app/Meal_Planner/dinner.dart';
import 'package:fitness_app/Meal_Planner/lunch.dart';
import 'package:fitness_app/Meal_Planner/snacks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class MealSchedule extends StatefulWidget {
  const MealSchedule({super.key});
  @override
  State createState() => _MealScheduleState();
}

class _MealScheduleState extends State {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal Schedule"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
              ),
              SizedBox(
                width:15,
              ),
              Text(
                "Today",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Breakfast"),
                    SizedBox(
                      height: 10,
                    ),
                    Breakfast(),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Lunch"),
                    SizedBox(
                      height: 10,
                    ),
                    Lunch(),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Dinner"),
                    SizedBox(
                      height: 10,
                    ),
                    Dinner(),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Snacks"),
                    SizedBox(
                      height: 10,
                    ),
                    Snacks(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
