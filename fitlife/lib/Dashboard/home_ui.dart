import 'dart:developer';

import 'package:fitlife/Dashboard/bottelShape.dart';
import 'package:fitlife/Dashboard/community.dart';
import 'package:fitlife/Dashboard/letest_workout_listView.dart';
import 'package:fitlife/Dashboard/profile_ui.dart';
import 'package:fitlife/Dashboard/reminder_ui.dart';

import 'package:fitlife/Firebase/Firestore/Meal/calories._intake.dart';
import 'package:fitlife/Firebase/Firestore/User/auth.dart';
import 'package:fitlife/Meal_Planner/mealHome.dart';
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
  const HomeUi({super.key});
  @override
  State createState() => _HomeUiState();
}

class _HomeUiState extends State {
  int step = 0;
  int stepsGoal = 10000;

  @override
  void initState() {
    super.initState();
    getCalories();
    requestPermission();
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
  }

  countSteps(StepCount count) {
    step = count.steps;
    setState(() {});
  }

  getCalories() {
    CaloriesIntake().getCaloriesIntakeData();
    setState(() {});
  }

  @override
  Widget build(context) {
    double progressVal = step / stepsGoal;
    return Stack(children: [
      Scaffold(
        body: SingleChildScrollView(
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
                    Text("Hello ,",
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w400)),
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
                        )),
                  ],
                ),
                Text(userData[0].userName,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 20)),
                const SizedBox(
                  height: 20,
                ),
                Text("Activity Status",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w500)),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 9, left: 15, right: 19, bottom: 10),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(217, 217, 217, 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Calories",
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w400)),
                      Text("Remaining=goal+Exercise",
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w300)),
                      Row(
                        children: [
                          const SizedBox(
                            width: 21,
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
                                    radius: 20,
                                    value: 30,
                                    color:
                                        const Color.fromRGBO(249, 198, 52, 1),
                                  ),
                                  PieChartSectionData(
                                    showTitle: false,
                                    color:
                                        const Color.fromRGBO(239, 152, 58, 1),
                                    radius: 20,
                                    value: 300,
                                  ),
                                  PieChartSectionData(
                                    color:
                                        const Color.fromRGBO(124, 117, 255, 1),
                                    showTitle: false,
                                    radius: 20,
                                    value: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 20, bottom: 10, top: 5),
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.flag,
                                      color: Color.fromRGBO(249, 198, 52, 1),
                                      size: 30,
                                    ),
                                    const SizedBox(
                                      height: 17,
                                    ),
                                    SvgPicture.asset(
                                      "assets/icon/dinner.svg",
                                      color:
                                          const Color.fromRGBO(239, 152, 58, 1),
                                      width: 20,
                                      height: 30,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SvgPicture.asset(
                                      "assets/icon/fire.svg",
                                      color: const Color.fromRGBO(
                                          124, 117, 255, 1),
                                      width: 20,
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Goal",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                  Text(userData[0].coloriesGoal.toString(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text("Food",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                  Text(CaloriesIntake.dayCalories.toString()),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text("Exercise",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                  Text("0",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                      ))
                                ],
                              ),
                              const SizedBox(
                                width: 21,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    // Steps Tracker

                    Container(
                      width: 150,
                      height: 180,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromRGBO(217, 217, 217, 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Steps",
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w400)),
                            const SizedBox(
                              height: 16,
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: CircularProgressIndicator(
                                    value: progressVal,
                                    backgroundColor: Colors.grey,
                                    strokeWidth: 13,
                                  ),
                                ),
                                Container(
                                    alignment: Alignment.center,
                                    width: 78,
                                    height: 78,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 10,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                      shape: BoxShape.circle,
                                      color: const Color.fromRGBO(
                                          146, 163, 253, 1),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/icon/walk.png",
                                          width: 23,
                                          height: 23,
                                        ),
                                        Text(
                                          "$step",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 150,
                      height: 180,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromRGBO(217, 217, 217, 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, top: 10, left: 13, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Water Intake",
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      CustomWaterBottomSheet
                                          .showWaterLevelBottomsheet(context);
                                    },
                                    child: Icon(Icons.add)),
                              ],
                            ),

                            // LiquidCustomProgressIndicator(
                            //   direction: Axis.vertical,
                            //   value: .3,
                            //   valueColor: AlwaysStoppedAnimation(Colors.blue),
                            //   shapePath: BottleShape().getPath(Size(50, 150)),
                            // )
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: LiquidCircularProgressIndicator(
                                value: 0.5, // Half-filled indicator
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.blueAccent),
                                backgroundColor: Colors.white,
                                borderColor: Colors.blueAccent,
                                borderWidth: 3.0,
                                direction: Axis.vertical,
                                center: Text(
                                    "50%"), // Change to horizontal or leave as default
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
                Text("Latest workout",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                LetestWorkoutListview(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset(
                    "assets/icon/home.svg",
                    width: 30,
                    height: 33,
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const WorkoutTracker();
                            },
                          ),
                        );
                      },
                      child: SvgPicture.asset(
                        "assets/icon/activity.svg",
                        width: 30,
                        height: 33,
                      )),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return Mealhome();
                      }));
                    },
                    child: Image.asset(
                      "assets/icon/meal.png",
                      width: 34,
                      height: 36,
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return Community();
                            },
                          ),
                        );
                      },
                      child: SvgPicture.asset(
                        "assets/icon/profile.svg",
                        width: 30,
                        height: 33,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      Positioned(
        bottom: 40,
        left: MediaQuery.of(context).size.width / 2 - 35,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.pinkAccent),
          child: const Icon(
            Icons.music_note,
            size: 43,
            color: Colors.white,
          ),
        ),
      )
    ]);
  }
}
