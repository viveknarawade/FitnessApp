import 'package:fitlife/workout/workoutCard.dart';
import 'package:fitlife/workout/workoutLineChart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutTracker extends StatefulWidget {
  const WorkoutTracker({super.key});

  @override
  State<WorkoutTracker> createState() => _WorkoutTrackerState();
}

class _WorkoutTrackerState extends State<WorkoutTracker> {
  List<Map<String, dynamic>> exerciseCardData = [
    {"title": "FullBody", "noOfExcercise": "11 Excercise", "min": "  32Mins"},
    {"title": "LowerBody", "noOfExcercise": "8 Excercise", "min": "  22Mins"},
    {"title": "UpperBody", "noOfExcercise": "5 Excercise", "min": "  76Mins"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "Workout Tracker",
                style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            backgroundColor: const Color.fromRGBO(148, 171, 253, 1.0),
            expandedHeight: MediaQuery.of(context).size.width * 0.9,
            elevation: 0.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding:
                    const EdgeInsets.only(top: 120.0, left: 30, bottom: 40),
                child: Workoutlinechart(),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0.0),
              child: Container(
                height: 32.0,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Container(
                  width: 65,
                  height: 5.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: const Color.fromRGBO(233, 232, 232, 1.0),
                  ),
                ),
              ),
            ),
            leadingWidth: 80,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "What Do You Want To Train",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold), // Optional styling
              ),
            ),
          ),
          Workoutcard(
            exerciseCardData: exerciseCardData,
          ),
        ],
      ),
    );
  }
}
