import 'dart:developer';

import 'package:fitlife/Firebase/Storage/exerciseData.dart';
import 'package:fitlife/workout/startExercise.dart';
import 'package:fitlife/workout/workout_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Exercisecard extends StatefulWidget {
  List<Map<String, dynamic>> tempexerciseData = [];
  Exercisecard({super.key, required this.tempexerciseData});

  @override
  State<Exercisecard> createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercisecard> {
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: widget.tempexerciseData.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return WorkoutDetail(
                      tempexerciseData: widget.tempexerciseData,
                    );
                  },
                ),
              );
            },
            child: Row(
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/workout/warm-up.png",
                    ),
                    const SizedBox(width: 19),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.tempexerciseData[index]["exersiceName"],
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.tempexerciseData[index]["reps"],
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Image.asset(
                  "assets/icon/Icon-Next.png",
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
