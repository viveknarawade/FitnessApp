import 'dart:developer';

import 'package:fitlife/Firebase/Firestore/workout/workout_calories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

class LetestWorkoutListview extends StatefulWidget {
  var upperbodyBurn;
  var lowerbodyBurn;
  var fullbodyBurn;
  LetestWorkoutListview(
      {super.key,
      required this.fullbodyBurn,
      required this.lowerbodyBurn,
      required this.upperbodyBurn});

  @override
  State<StatefulWidget> createState() {
    return _LetestWorkoutListviewState();
  }
}

class _LetestWorkoutListviewState extends State<LetestWorkoutListview> {
  @override
  void initState() {
    super.initState();
    get();
  }

  List<Map> letestBurnMap = [];

  get() async {
    log("Call from letest");

    setState(() {
      if (widget.upperbodyBurn > 0) {
        letestBurnMap.add({
          "WorkoutName": "UpperBody Workout",
          "burn": widget.upperbodyBurn,
        });
      }
      if (widget.lowerbodyBurn > 0) {
        letestBurnMap.add({
          "WorkoutName": "LowerBody Workout",
          "burn": widget.lowerbodyBurn,
        });
      }
      if (widget.fullbodyBurn > 0) {
        letestBurnMap.add({
          "WorkoutName": "FullBody Workout",
          "burn": widget.fullbodyBurn,
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: letestBurnMap.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
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
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(letestBurnMap[index]["WorkoutName"]),
                  const SizedBox(height: 2),
                  Text("${letestBurnMap[index]["burn"]} calories burned"),
                  const SizedBox(height: 7),
                  SimpleAnimationProgressBar(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ratio: letestBurnMap[index]["burn"] / 1000, // Example ratio
                    width: 170,
                    height: 13,
                    direction: Axis.horizontal,
                    backgroundColor: const Color.fromRGBO(247, 248, 248, 1),
                    foregrondColor: const Color.fromRGBO(159, 158, 251, 1),
                    duration: const Duration(seconds: 3),
                    curve: Curves.fastLinearToSlowEaseIn,
                  ),
                  const SizedBox(height: 17),
                ],
              ),
              const Spacer(),
              GestureDetector(
                child: SvgPicture.asset(
                  "assets/icon/next-btn.svg",
                  width: 40,
                  height: 35,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
