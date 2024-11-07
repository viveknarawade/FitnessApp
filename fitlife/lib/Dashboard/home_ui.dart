
import 'package:fitlife/Dashboard/letest_workout_listView.dart';
import 'package:fitlife/Dashboard/profile_ui.dart';
import 'package:fitlife/Dashboard/reminder_ui.dart';
import 'package:fitlife/Meal_Planner/mealHome.dart';
import 'package:fitlife/workout/workoutTracker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({super.key});
  @override
  State createState() => _HomeUiState();
}

class _HomeUiState extends State {
  @override
  Widget build(context) {
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
                    Text("Hello ,", style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w400)),
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
                Text("Vivek Narawade",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 20)),
                const SizedBox(
                  height: 20,
                ),
                Text("Activity Status",
                    style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500)),
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
                      
                       style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w400)
                      ),
                       Text("Remaining=goal+Exercise",
                       style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w300)
                      
                      ),
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
                       style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500)
                                  
                                  ),
                                  Text("2,340",
                       style: GoogleFonts.poppins(fontSize: 14,)
                                  
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text("Food",
                       style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500)
                                  
                                  ),
                                  const Text("0"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text("Exercise",
                       style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500)
                                  
                                  ),
                                  Text("0",
                       style: GoogleFonts.poppins(fontSize: 14,)
                                  
                                  )
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
                             Text(
                              "Steps",

                       style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w400)

                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                const SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: CircularProgressIndicator(
                                    value: .7,
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
                                        const Text(
                                          "684 meter",
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
                      width: 140,
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
                      // ignore: prefer_const_constructors
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Water Intake",

                       style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w400)

                            ),
                            const SizedBox(
                              height: 6,
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
                       style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w400)
                
                ),
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
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const WorkoutTracker();
                        }));
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
                              return ProfileUi();
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
