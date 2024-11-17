import 'dart:developer';

import 'package:fitlife/Firebase/Firestore/Meal/calories._intake.dart';
import 'package:fitlife/Firebase/Firestore/Meal/meal_Intake.dart';
import 'package:fitlife/Meal_Planner/mealSchedule.dart';
import 'package:fitlife/Model/date_time_day.dart';
import 'package:fitlife/workout/workoutSchedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Detail extends StatefulWidget {
  final Map<String, dynamic> itemData;
  String specificImage;
  String category;
  Detail({Key? key, required this.itemData, required this.category,required this.specificImage})
      : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  @override
  
  @override
  Widget build(BuildContext context) {
    log("SPecific Image:${widget.specificImage}");

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color.fromRGBO(148, 171, 253, 1.0),
            expandedHeight: MediaQuery.of(context).size.width * 0.8,
            elevation: 0.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 100),
                    alignment: Alignment.center,
                    height: 270,
                    width: 280,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(183, 206, 254, 0.5),
                    ),
                  ),
                  Positioned(
                    
                    top: 140,
                    child: Image.asset(
                    widget.specificImage,
                      height: 220,
                      width: 220,
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
                  color: Colors.white,
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
                    color: const Color.fromRGBO(233, 232, 232, 1.0),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.itemData["food_item"],
                    style: GoogleFonts.poppins(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Nutrition",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Increased font size for Calories
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromRGBO(148, 171, 253, 1.0),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icon/calories.svg",
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  widget.itemData["calories"],
                                  style: GoogleFonts.poppins(
                                    fontSize: 16, // Increased font size
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Calories",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Increased font size for Fat
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromRGBO(148, 171, 253, 1.0),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icon/Fat-Icon.svg",
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  widget.itemData["fat"],
                                  style: GoogleFonts.poppins(
                                    fontSize: 16, // Increased font size
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Fat",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Increased font size for Protein
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromRGBO(148, 171, 253, 1.0),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icon/protein1.svg",
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  widget.itemData["protein"],
                                  style: GoogleFonts.poppins(
                                    fontSize: 16, // Increased font size
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Protein",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Increased font size for Carbs
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromRGBO(148, 171, 253, 1.0),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icon/Carbo-Icon.svg",
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  widget.itemData["carbs"],
                                  style: GoogleFonts.poppins(
                                    fontSize: 16, // Increased font size
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Carbs",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Descriptions",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      widget.itemData["description"],
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        
                    

                        // Print the formatted time, date, and day
                        log("Current Time: ${DateTimeDay().formattedTime}");
                        log("Current Date: ${DateTimeDay().formattedDate}");
                        log("Day of the Week: ${DateTimeDay().dayOfWeek}");
                        widget.itemData.addAll(
                          {
                            "Time": "${DateTimeDay().formattedTime}",
                            "Date": " ${DateTimeDay().formattedDate}",
                            "Day": "${DateTimeDay().dayOfWeek}"
                          },
                        );

                        CaloriesIntake()
                            .addDayCaloriesData(widget.itemData["calories"]);

                        print(widget.itemData);
                        MealIntake()
                            .addMealData(widget.category, widget.itemData);

                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromRGBO(148, 171, 253, 1.0),
                        ),
                        child: Text(
                          "Add to ${widget.category} Meal",
                          style: GoogleFonts.poppins(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
