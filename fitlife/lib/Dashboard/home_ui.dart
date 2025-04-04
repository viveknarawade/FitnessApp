import 'dart:developer';

import 'package:fitlife/Dashboard/reminder_ui.dart';

import 'package:fitlife/Firebase/Firestore/Meal/calories._intake.dart';

import 'package:fitlife/Firebase/Firestore/workout/calories_burn.dart';
import 'package:fitlife/Firebase/Firestore/workout/workout_calories.dart';
import 'package:fitlife/Meal_Planner/mealHome.dart';
import 'package:fitlife/Model/session_data.dart';
import 'package:fitlife/main.dart';
import 'package:fitlife/widget/custom_navbar.dart';
import 'package:fitlife/workout/workoutTracker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import 'package:fitlife/widget/CustomWaterBottomSheet.dart';

class HomeUi extends StatefulWidget {
  int? liter;
  HomeUi({this.liter, super.key});

  @override
  State createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {
  int step = 0;
  int stepsGoal = 10000;
  double waterIntakeGoal = 2500.0;
  double Goal = SessionData.coloriesGoal!;
  int Food = 0;
  int Exercise = 0;
  double waterIntakeVal = 0;

  @override
  void initState() {
    super.initState();
    requestPermission();
    fetchWaterIntake();
    getLestestWorkoutData();
  }

  fetchWaterIntake() async {
    int todayWaterIntake =
        await MainApp().sqfliteObj?.getTodayWaterIntake() ?? 0;
    setState(() {
      // Calculate water intake percentage
      waterIntakeVal = todayWaterIntake / waterIntakeGoal;
      if (waterIntakeVal > 1.0) {
        waterIntakeVal = 1.0; // Ensure it doesn't exceed 100%
      }
    });
  }

  // Request the permisson for pedometer
  requestPermission() async {
    if (await Permission.activityRecognition.isGranted) {
      startListning();
    } else {
      if (await Permission.activityRecognition.request().isGranted) {
        await startListning();
      }
    }
  }

  startListning() async {
    await Pedometer.stepCountStream.listen(countSteps);
    setState(() {});
  }

  countSteps(StepCount count) {
    step = count.steps;
    setState(() {});
  }

  /// for getting  calories
  getCalories() async {
    Food = await CaloriesIntake().getCaloriesIntakeData();
    Exercise = await CaloriesBurn().getCaloriesBurnData();
    setState(() {});
  }

// letest card
  List<Map> letestBurnMap = [];

  /// for getting letest card data
  Future<void> getLestestWorkoutData() async {
    num upperBurn = await WorkoutCalories().getTotalCalories("UpperBody");
    num lowerBurn = await WorkoutCalories().getTotalCalories("LowerBody");
    num fullBurn = await WorkoutCalories().getTotalCalories("FullBody");

    log("upperBurn : $upperBurn");
    log("lowerBurn : $lowerBurn");
    log("fullBurn : $fullBurn");

    List<Map> tempBurnMap = [];

    if (upperBurn > 0) {
      tempBurnMap.add({
        "WorkoutName": "UpperBody Workout",
        "burn": upperBurn,
      });
    }
    if (lowerBurn > 0) {
      tempBurnMap.add({
        "WorkoutName": "LowerBody Workout",
        "burn": lowerBurn,
      });
    }
    if (fullBurn > 0) {
      tempBurnMap.add({
        "WorkoutName": "FullBody Workout",
        "burn": fullBurn,
      });
    }

    // Use setState after async operation completes
    setState(() {
      letestBurnMap = tempBurnMap;
    });
  }

  @override
  Widget build(context) {
    double progressVal = step / stepsGoal;
    getCalories();
    // Calculate the total  percentage values
    double total = Goal + Food + Exercise;
    double goalPercentage = (Goal / total) * 100;
    double foodPercentage = (Food / total) * 100;
    double exercisePercentage = (Exercise / total) * 100;

    double remainingPercentage = (Goal - Exercise) - Food;
    log(remainingPercentage.toString());

    return Stack(children: [
      Scaffold(
        body: RefreshIndicator(
          onRefresh: getLestestWorkoutData,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Text(
                        "Hello ,",
                        style: GoogleFonts.poppins(
                            fontSize: 23, fontWeight: FontWeight.w400),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return const ReminderUi();
                              },
                            ),
                          );
                        },
                        child: SvgPicture.asset(
                          "assets/icon/bell-home.svg",
                          height: 2,
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${SessionData.userName!}",
                    style: GoogleFonts.poppins(
                        color: Color(0xFF5D7AEA),
                        fontWeight: FontWeight.w500,
                        fontSize: 32),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Activity Status",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //CAOLRIES CARD
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Calories",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Remaining = Goal + Exercise",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: PieChart(
                                  swapAnimationDuration:
                                      const Duration(milliseconds: 700),
                                  PieChartData(
                                    centerSpaceRadius: 30,
                                    sections: [
                                      PieChartSectionData(
                                        showTitle: false,
                                        radius: 22,
                                        value: goalPercentage,
                                        color: const Color(0xFFF9C634),
                                      ),
                                      PieChartSectionData(
                                        showTitle: false,
                                        radius: 22,
                                        value: foodPercentage,
                                        color: const Color(0xFFEF983A),
                                      ),
                                      PieChartSectionData(
                                        showTitle: false,
                                        radius: 22,
                                        value: exercisePercentage,
                                        color: const Color(0xFF7C75FF),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 50),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.flag,
                                            color: Color(0xFFF9C634), size: 28),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            "Goal: ${Goal.toInt()}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icon/dinner.svg",
                                          color: const Color(0xFFEF983A),
                                          width: 24,
                                          height: 24,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            "Food: $Food",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icon/fire.svg",
                                          color: const Color(0xFF7C75FF),
                                          width: 24,
                                          height: 24,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            "Exercise: $Exercise",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    // Row(
                                    //   children: [
                                    //     // SvgPicture.asset(
                                    //     //   "assets/icon/fire.svg",
                                    //     //   color: const Color(0xFF7C75FF),
                                    //     //   width: 24,
                                    //     //   height: 24,
                                    //     // ),
                                    //     const SizedBox(width: 8),
                                    //     Expanded(
                                    //       child: Text(
                                    //         "Remaining: ${remainingPercentage.toInt()}",
                                    //         style: GoogleFonts.poppins(
                                    //           fontSize: 15,
                                    //           fontWeight: FontWeight.w500,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      // Steps Tracker
                      Card(
                        elevation: 7,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 25, right: 25, bottom: 15, top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Daily Steps",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.deepPurple[800],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: 120,
                                    height: 120,
                                    child: CircularProgressIndicator(
                                      value: progressVal,
                                      backgroundColor: Colors.purple[100],
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.deepPurple),
                                      strokeWidth: 15,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.purple.withOpacity(0.3),
                                          spreadRadius: 3,
                                          blurRadius: 8,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.deepPurple[300]!,
                                          Colors.deepPurple[500]!,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/icon/walk.png",
                                          width: 30,
                                          height: 30,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "$step",
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),

                      // WATER INTAKE
                      Card(
                        elevation: 7,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Water Intake",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.deepPurple[800],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CustomWaterBottomSheet()),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.deepPurple[50],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: EdgeInsets.all(6),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.deepPurple[800],
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                width: 110,
                                height: 110,
                                child: LiquidCircularProgressIndicator(
                                  value: waterIntakeVal,
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.blue[400]!),
                                  backgroundColor: Colors.blue[50],
                                  borderColor: Colors.blue[300]!,
                                  borderWidth: 3.0,
                                  direction: Axis.vertical,
                                  center: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${(waterIntakeVal * 100).toStringAsFixed(0)}%",
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.deepPurple[800],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Latest Workout",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(
                      height: 8), // Add consistent spacing explicitly

                  RefreshIndicator(
                    onRefresh: getLestestWorkoutData,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: letestBurnMap.length,
                      itemBuilder: (context, index) {
                        final workout = letestBurnMap[index];
                        return Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Workout Icon
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(255, 102, 102, 1),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/workout/fullbody.svg",
                                    fit: BoxFit.contain,
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),

                              // Workout Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      workout["WorkoutName"],
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${workout["burn"]} calories burned",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(height: 10),

                                    // Progress Bar
                                    SimpleAnimationProgressBar(
                                      borderRadius: BorderRadius.circular(20),
                                      ratio: workout["burn"] /
                                          1000, // Example ratio
                                      width: MediaQuery.of(context).size.width *
                                          0.55,
                                      height: 10,
                                      direction: Axis.horizontal,
                                      backgroundColor: const Color.fromRGBO(
                                          247, 248, 248, 1),
                                      foregrondColor: const Color.fromRGBO(
                                          159, 158, 251, 1),
                                      duration: const Duration(seconds: 2),
                                      curve: Curves.easeInOut,
                                    ),
                                  ],
                                ),
                              ),

                              // Next Button
                              GestureDetector(
                                child: SvgPicture.asset(
                                  "assets/icon/next-btn.svg",
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: CustomNavbar.showCustomAppbar(context),
      ),
    ]);
  }
}
