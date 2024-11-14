import 'package:fitlife/Meal_Planner/dinner.dart';

import 'package:fitlife/Meal_Planner/snacks.dart';
import 'package:fitlife/widget/custom_listview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MealSchedule extends StatefulWidget {
  final List<Map<String, dynamic>> mealBreakfastScheduleData;
  final List<Map<String, dynamic>> mealLunchScheduleData;
  final List<Map<String, dynamic>> mealDinnerScheduleData;

  const MealSchedule({
    Key? key,
    required this.mealBreakfastScheduleData,
    required this.mealLunchScheduleData,
    required this.mealDinnerScheduleData,
  }) : super(key: key);

  @override
  State createState() => _MealScheduleState();
}

class _MealScheduleState extends State<MealSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal Schedule"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.arrow_back_ios, color: Colors.grey),
              const SizedBox(width: 15),
              Text(
                "Today",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 20),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text("Breakfast"),
                    const SizedBox(height: 10),
                    CustomListview(
                      data: widget.mealBreakfastScheduleData,
                      categories: "Breakfast",
                    ),
                    const SizedBox(height: 20),
                    const Text("Lunch"),
                    const SizedBox(height: 10),
                    CustomListview(
                        data: widget.mealLunchScheduleData,
                        categories: "Lunch"),
                    const SizedBox(height: 20),
                    const Text("Dinner"),
                    const SizedBox(height: 10),
                    CustomListview(
                        data: widget.mealDinnerScheduleData,
                        categories: "Dinner"),
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
