import 'package:fitness_app/workout/workoutType.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Workoutcard extends StatefulWidget {
  const Workoutcard({super.key});

  @override
  State<Workoutcard> createState() => _WorkoutcardState();
}

class _WorkoutcardState extends State<Workoutcard> {
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount: 4,
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
                        "FullBody Workout",
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "11 Exercises | 32mins",
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
                                return workoutType();
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
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30, left: 30),
                        alignment: Alignment.center,
                        height: 80,
                        width: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(247, 248, 248, 1.0),
                        ),
                      ),
                      Positioned(
                        child: Image.asset(
                          "assets/workout/skipping.png",
                          height: 140,
                          width: 140,
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
