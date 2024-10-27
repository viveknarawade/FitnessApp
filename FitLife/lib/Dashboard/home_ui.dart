import 'package:fitness_app/Dashboard/profile_ui.dart';
import 'package:fitness_app/Dashboard/reminder_ui.dart';
import 'package:fitness_app/Meal_Planner/mealHome.dart';
import 'package:fitness_app/workout/workoutTracker.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome Back", style: GoogleFonts.poppins(fontSize: 18)),
            Text("Yash Narawade",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500, fontSize: 20)),
          ],
        ),
        actions: [
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
              child: const Icon(Icons.notification_add)),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Activity Status"),
              const SizedBox(
                height: 20,
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
                    const Text("Calories"),
                    const Text("Remaining=goal+Exercise"),
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
                                  color: Color.fromRGBO(249, 198, 52, 1),
                                ),
                                PieChartSectionData(
                                  showTitle: false,
                                  color: Color.fromRGBO(239, 152, 58, 1),
                                  radius: 20,
                                  value: 300,
                                ),
                                PieChartSectionData(
                                  color: Color.fromRGBO(124, 117, 255, 1),
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
                              padding:
                                  const EdgeInsets.only(right: 20, bottom: 10,top: 5),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.flag,
                                    color: Color.fromRGBO(249, 198, 52, 1),
                                    size: 30,
                                  ),
                                  const SizedBox(
                                    height: 17,
                                  ),
                                  SvgPicture.asset(
                                    "assets/icon/dinner.svg",
                                    color: Color.fromRGBO(239, 152, 58, 1),
                                    width: 20,
                                    height: 30,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SvgPicture.asset(
                                    "assets/icon/fire.svg",
                                    color: Color.fromRGBO(124, 117, 255, 1),
                                    width: 20,
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Goal"),
                                Text("2,340"),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("Food"),
                                Text("0"),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("Exercise"),
                                Text("0")
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
                            color: Colors.grey.withOpacity(0.7), // Shadow color
                            spreadRadius: 5, // Spread of the shadow
                            blurRadius: 10, // Softness of the shadow
                            offset:
                                const Offset(0, 3), // Position of shadow (x, y)
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 7, 137, 38)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Steps",
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
                                        color: Colors.grey
                                            .withOpacity(0.5), // Shadow color
                                        spreadRadius: 5, // Spread of the shadow
                                        blurRadius:
                                            10, // Softness of the shadow
                                        offset: const Offset(
                                            0, 3), // Position of shadow (x, y)
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                    color:
                                        const Color.fromRGBO(146, 163, 253, 1),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                  Spacer(),
                  Container(
                    width: 140,
                    height: 180,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7), // Shadow color
                            spreadRadius: 5, // Spread of the shadow
                            blurRadius: 10, // Softness of the shadow
                            offset:
                                const Offset(0, 3), // Position of shadow (x, y)
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 7, 137, 38)),
                    // ignore: prefer_const_constructors
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Water Intake",
                          ),
                          SizedBox(
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
              const Text("Latest workout"),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          "assets/workout/fullbody.svg",
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("FullBodyWorkout"),
                          const SizedBox(
                            height: 2,
                          ),
                          Text("180 Calories burn | 20 min"),
                          const SizedBox(
                            height: 7,
                          ),
                          SimpleAnimationProgressBar(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            ratio: .5,
                            width: 170,
                            height: 13,
                            direction: Axis.horizontal,
                            backgroundColor:
                                const Color.fromRGBO(247, 248, 248, 1),
                            foregrondColor: Color.fromRGBO(159, 158, 251, 1),
                            duration: Duration(seconds: 3),
                            curve: Curves.fastLinearToSlowEaseIn,
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: SvgPicture.asset(
                          "assets/icon/next-btn.svg",
                          width: 40,
                          height: 35,
                        ),
                      ),
                    ],
                  );
                },
              )
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
                SvgPicture.asset("assets/icon/home.svg"),
                const SizedBox(
                  width: 50,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return WorkoutTracker();
                      }));
                    },
                    child: SvgPicture.asset("assets/icon/activity.svg")),
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
                    width: 28,
                    height: 40,
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
                    child: SvgPicture.asset("assets/icon/profile.svg")),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: const Icon(Icons.music_note_outlined),
      ),
    );
  }
}
