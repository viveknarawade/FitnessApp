import 'package:fitness_app/workout/startExercise.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Exercisecard extends StatefulWidget {
  const Exercisecard({super.key});

  @override
  State<Exercisecard> createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercisecard> {
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                        "Warm Up",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "05.00",
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
        );
      },
    );
  }
}
