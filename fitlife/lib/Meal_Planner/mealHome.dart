import 'dart:developer';

import 'package:fitlife/Firebase/Firestore/Meal/meal_Intake.dart';
import 'package:fitlife/Meal_Planner/mealLineChart.dart';
import 'package:fitlife/Meal_Planner/mealSchedule.dart';
import 'package:fitlife/Meal_Planner/mealCategory.dart';
import 'package:fitlife/Firebase/Storage/foodData.dart';
import 'package:fitlife/widget/custom_navbar.dart';
import 'package:fitlife/widget/custom_listview.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Mealhome extends StatefulWidget {
  const Mealhome({super.key});

  @override
  createState() => _MealhomeState();
}

List foodCategory = [
  {
    'name': 'Breakfast',
    'image': "assets/meal/breakfast.png",
  },
  {
    'name': "Lunch",
    'image': "assets/meal/lunch.png",
  },
  {
    'name': "Dinner",
    'image': "assets/meal/dinner.png",
  }
]; // Food categories list

class _MealhomeState extends State<Mealhome> {
  String? selectedCategoryValue = "Breakfast"; // Default value is "Breakfast"
  List<Map<String, dynamic>> localMealData = [];

  getLocalData({String? category}) async {
    MealIntake mealIntake = MealIntake();
    await mealIntake.getMealData();

    if (!mounted) return; // <-- Prevent setState() if widget is disposed

    if (category == "Dinner") {
      localMealData = mealIntake.mealDinnerData;
    } else if (category == "Lunch") {
      localMealData = mealIntake.mealLunchData;
    } else {
      localMealData = mealIntake.mealBreakfastData;
    }

    setState(() {}); // Only update state if widget is still in the tree
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocalData(category: selectedCategoryValue);
    reload();
  }

reload() {
  WeeklyCaloriesChart(); // This doesn’t modify state
  setState(() {}); // Unnecessary
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal Planner"),
        backgroundColor: Colors.white,
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
              const SizedBox(height: 40),
              WeeklyCaloriesChart(),
              const SizedBox(height: 10),

              // Daily Meal Schedule
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
                        backgroundColor: MaterialStatePropertyAll(
                          Color.fromRGBO(147, 168, 253, 1),
                        ),
                      ),
                      onPressed: () async {
                        MealIntake mealIntake = MealIntake();

                        await mealIntake.getMealData();

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return MealSchedule(
                                mealBreakfastScheduleData:
                                    mealIntake.mealBreakfastData,
                                mealLunchScheduleData: mealIntake.mealLunchData,
                                mealDinnerScheduleData:
                                    mealIntake.mealDinnerData,
                              );
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Check",
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Today Meals - Dropdown for meal selection
              Row(
                children: [
                  Text(
                    "Today Meals",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromRGBO(234, 239, 255, 1)),
                    child: Row(
                      children: [
                        // Display the selected category value in the Text widget
                        DropdownButton<String>(
                          value: selectedCategoryValue,

                          icon: Icon(Icons.arrow_downward_outlined),
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors
                                .black, // Set text color to black for the selected item
                          ),
                          dropdownColor: Colors
                              .white, // Optional: Set the background color of the dropdown menu
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCategoryValue =
                                  newValue; // Update selected category
                              getLocalData(category: selectedCategoryValue);
                            });
                          },
                          items: <String>["Breakfast", "Lunch", "Dinner"]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: GoogleFonts.poppins(
                                  color: Colors
                                      .black, // Set text color to black for each dropdown item
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CustomListview(
                data: localMealData,
                categories: selectedCategoryValue,
              ),
              const SizedBox(height: 10),

              // Finding Something to Eat
              Text(
                "Finding Something to Eat",
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),

              // Horizontal list of food categories
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: foodCategory.length,
                    itemBuilder: (context, index) {
                      // Define color palette variations
                      final colorVariations = [
                        {
                          'background':
                              Color.fromRGBO(255, 240, 245, 1), // Soft Lavender
                          'accent':
                              Color.fromRGBO(199, 21, 133, 1), // Soft Raspberry
                          'button':
                              Color.fromRGBO(186, 85, 211, 1), // Soft Orchid
                        },
                        {
                          'background':
                              Color.fromRGBO(230, 248, 242, 1), // Mint Green
                          'accent': Color.fromRGBO(46, 139, 87, 1), // Sea Green
                          'button': Color.fromRGBO(
                              60, 179, 113, 1), // Medium Sea Green
                        },
                        {
                          'background':
                              Color.fromRGBO(255, 248, 220, 1), // Cornsilk
                          'accent':
                              Color.fromRGBO(210, 105, 30, 1), // Chocolate
                          'button':
                              Color.fromRGBO(184, 134, 11, 1), // Dark Goldenrod
                        }
                      ];

                      final currentColorScheme =
                          colorVariations[index % colorVariations.length];

                      return Stack(children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.only(
                              top: 120, left: 20, right: 90, bottom: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(100),
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            ),
                            color: currentColorScheme['background'],
                          ),
                          child: Column(
                            children: [
                              Text(
                                foodCategory[index]['name'],
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: currentColorScheme['accent']),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "20+ Foods",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: currentColorScheme['accent']),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      currentColorScheme['button']),
                                ),
                                onPressed: () async {
                                  List<Map<String, dynamic>> tempFoodData =
                                      await Food().getFoodData(
                                          foodCategory[index]['name']);

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        log("SELECT BUTTON CLICKED");
                                        return Category(
                                          category: foodCategory[index]['name'],
                                          itemsData: tempFoodData,
                                        );
                                      },
                                    ),
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
                          left: 70,
                          bottom: 130,
                          child: Image.asset(
                            foodCategory[index]['image'],
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
