import 'dart:developer';

import 'package:fitlife/Firebase/Storage/exerciseData.dart';
import 'package:fitlife/workout/exerciseCard.dart';

import 'package:fitlife/workout/workoutSchedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class workoutType extends StatefulWidget {
  List<Map<String, dynamic>> exerciseCardData = [];
  String workoutTypeName;
  List workoutImags = [];
  String? workoutTypeImage;
  workoutType(
      {super.key,
      required this.exerciseCardData,
      required this.workoutTypeName,
      required this.workoutImags,
      required this.workoutTypeImage});

  @override
  State<workoutType> createState() => _FullbodyState();
}

class _FullbodyState extends State<workoutType> {
 
  List<Map<String, dynamic>> tempexerciseData = [];
  storeData() async {
    tempexerciseData =
        await ExerciseStorage().getExerciseData(widget.workoutTypeName);
    log("tempexerciseData = $tempexerciseData");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    log("in initState ");
    log("${widget.workoutTypeImage}");
    storeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE), // Soft light blue background
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFF5D7AEA), // Deep periwinkle blue
            expandedHeight: MediaQuery.of(context).size.width * 0.8,
            elevation: 0.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 100, left: 65),
                    alignment: Alignment.center,
                    height: 270,
                    width: 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFAEC6FF)
                          .withOpacity(0.5), // Soft blue with transparency
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 100,
                    child: SvgPicture.asset(
                      "${widget.workoutTypeImage}",
                      height: 250,
                      width: 250,
                    ),
                  ),
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Container(
                height: 50.0,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: const Color(0xFFEDF2FF),
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
                    color: const Color(0xFFE0E0E0), // Soft gray
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.workoutTypeName + "  Workout",
                    style: GoogleFonts.poppins(
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF333333)), // Dark gray for text
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFFEDF2FF)), // Soft pastel blue
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Workoutschedule();
                        }));
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icon/Calendar.svg",
                            width: 18,
                            height: 27,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Schedule Workout ",
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: const Color(
                                    0xFF333333)), // Dark gray for text
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios,
                              color: const Color(
                                  0xFF666666)) // Softer gray for icon
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "Exercises",
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF333333)), // Dark gray for text
                  ),
                ],
              ),
            ),
          ),
          Exercisecard(
            tempexerciseData: tempexerciseData,
            workoutImags: widget.workoutImags,
            workoutTypeName: widget.workoutTypeName,
          ),
        ],
      ),
    );
  }
}
