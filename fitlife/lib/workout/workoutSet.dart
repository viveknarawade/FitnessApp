import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';

class Workoutset extends StatefulWidget {
  final List<Map<String, dynamic>> exerciseCardData;
  const Workoutset({super.key, required this.exerciseCardData});

  @override
  State<Workoutset> createState() => _WorkoutsetState();
}

class _WorkoutsetState extends State<Workoutset> {
  TextEditingController setController = TextEditingController();
  List<int> sets = [1, 2, 3];
  addSet() {
    sets.add(sets.length + 1);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    log("EXERCISE DATA${widget.exerciseCardData}");
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.exerciseCardData.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  widget.exerciseCardData[index]["exersiceName"],
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(
                    width: 88,
                  ),
                  Text(
                    "Set",
                    style: GoogleFonts.poppins(fontSize: 18),
                  ),
                  const SizedBox(
                    width: 80,
                  ),
                  Text("Reps", style: GoogleFonts.poppins(fontSize: 18)),
                ],
              ),
              
              Center(
                child: GestureDetector(
                  onTap: () {
                    addSet();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, right: 24),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "Add Set",
                      style: GoogleFonts.poppins(
                          fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
