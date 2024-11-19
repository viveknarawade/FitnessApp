import 'package:fitlife/workout/workoutTracker.dart';
import 'package:fitlife/workout/workoutType.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Workoutcard extends StatefulWidget {
  List<Map<String, dynamic>> exerciseCardData = [];
  Workoutcard({
    super.key,
    required this.exerciseCardData,
  });

  @override
  State<Workoutcard> createState() => _WorkoutcardState();
}

class _WorkoutcardState extends State<Workoutcard> {
  workoutCategoryImages(int index) {
    if (widget.exerciseCardData[index]["title"] == "FullBody") {
      return WorkoutTracker().fullBodyImages;
    } else if (widget.exerciseCardData[index]["title"] == "LowerBody") {
      return WorkoutTracker().lowerbodyImages;
    } else {
      return WorkoutTracker().upperbodyImages;
    }
  }

  List workoutImages = [
    "assets/workout/fullbody.svg",
    "assets/workout/lowerbody.svg",
    "assets/workout/upperbody.svg"
  ];
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount: widget.exerciseCardData.length,
        itemBuilder: (context, index) {
          return Container(
            height: 135,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromRGBO(234, 239, 254, 1.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.exerciseCardData[index]["title"] + "  Workout",
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.exerciseCardData[index]["noOfExcercise"] +
                            widget.exerciseCardData[index]["min"],
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return workoutType(
                                    exerciseCardData: widget.exerciseCardData,
                                    workoutTypeName:
                                        widget.exerciseCardData[index]["title"],
                                    workoutImags: workoutCategoryImages(index),
                                   workoutTypeImage: workoutImages[index],);
                              },
                            ),
                          );
                        },
                        child: Container(
                          height: 30,
                          width: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(247, 248, 248, 1.0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "View more",
                            style: GoogleFonts.poppins(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 35),
                        alignment: Alignment.center,
                        height: 90,
                        width: 90,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(247, 248, 248, 1.0),
                        ),
                      ),
                      Positioned(
                        left: 13,
                        top: 12,
                        child: SvgPicture.asset(
                          workoutImages[index],
                          height: 70,
                          width: 70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
