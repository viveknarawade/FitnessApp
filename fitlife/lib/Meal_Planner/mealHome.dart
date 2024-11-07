import 'package:fitlife/Meal_Planner/mealLineChart.dart';
import 'package:fitlife/Meal_Planner/mealSchedule.dart';
import 'package:fitlife/Meal_Planner/mealCategory.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Mealhome extends StatefulWidget {
  createState() => _MealhomeState();
}

class _MealhomeState extends State {
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal Planner"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Meal Nutrition",
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 40,
              ),
              Meallinechart(),
              const SizedBox(
                height: 10,
              ),

              // Daily Meal Shedule

              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(234, 239, 255, 1)),
                child: Row(
                  children: [
                    Text(
                      "Daily Meal Schedule",
                      style: GoogleFonts.poppins(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Color.fromRGBO(147, 168, 253, 1),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return MealSchedule();
                        }));
                      },
                      child: Text(
                        "Check",
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              //  Today Meals
              Row(
                children: [
                  Text(
                    "Today Meals",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromRGBO(234, 239, 255, 1)),
                    child: const Row(
                      children: [
                        Text("Breakfast"),
                        SizedBox(
                          width: 7,
                        ),
                        Icon(Icons.arrow_downward_outlined)
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(234, 239, 255, 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset("assets/meal/meal1.svg"),
                        const SizedBox(
                          width: 30,
                        ),
                        const Column(
                          children: [
                            Text("Salmon Nigiri"),
                            Text("Today | 7 am"),
                          ],
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      "assets/icon/bell.svg",
                      width: 30,
                      height: 23,
                    ),
                  ],
                ),
              ),

              Text(
                "Finding Something to Eat",
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Stack(children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.only(
                              top: 120, left: 20, right: 90, bottom: 14),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(100),
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            ),
                            color: Color.fromRGBO(235, 242, 255, 1),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Breakfast",
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "20+ Foods",
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    Color.fromRGBO(147, 168, 253, 1),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                      return Category();
                                    }),
                                  );
                                },
                                child: Text(
                                  "Select",
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 52,
                          top: 5,
                          child: SvgPicture.asset(
                            "assets/meal/meal2.svg",
                            width: 130,
                          ),
                        ),
                      ]);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
