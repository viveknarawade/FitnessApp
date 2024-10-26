import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Workoutset extends StatefulWidget {
  const Workoutset({super.key});

  @override
  State<Workoutset> createState() => _WorkoutsetState();
}

class _WorkoutsetState extends State<Workoutset> {
  List<int> sets = [1, 2, 3];
  addSet() {
    sets.add(sets.length + 1);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  "Skipping",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  Text("Set", style: GoogleFonts.poppins(fontSize: 18)),
                  const SizedBox(
                    width: 60,
                  ),
                  Text("Kg", style: GoogleFonts.poppins(fontSize: 18)),
                  const SizedBox(
                    width: 83,
                  ),
                  Text("Reps", style: GoogleFonts.poppins(fontSize: 18)),
                  //  Spacer(),
                ],
              ),
              for (int i = 1; i <= sets.length; i++)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("$i", style: GoogleFonts.poppins(fontSize: 20)),
                        for (int j = 0; j < 2; j++)
                          const Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 4.0),
                            child: SizedBox(
                              height: 33,
                              width: 75,
                              child: TextField(
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 8),
                                ),
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                              ),
                              GestureDetector(
                                child: SvgPicture.asset(
                                  "assets/icon/correct.svg",
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
