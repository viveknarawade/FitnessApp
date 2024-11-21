import 'dart:developer';

import 'package:fitlife/Firebase/Storage/foodData.dart';
import 'package:fitlife/Meal_Planner/mealDetail.dart';
import 'package:fitlife/Meal_Planner/mealHome.dart';
import 'package:fitlife/widget/colorsList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Category extends StatefulWidget {
  String category;
  List<Map<String, dynamic>> itemsData;

  // Constructor to accept the selected category and item data
  Category({
    super.key,
    required this.category,
    required this.itemsData,
  });

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.category,
          style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text("Recommendation for Diet",
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.itemsData.length,
                itemBuilder: (context, index) {
                  final foodItem = widget.itemsData[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Detail(
                            itemData: foodItem,
                            category: widget.category,
                            img: foodItem["img"],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromRGBO(234, 239, 254, 1.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colorslist().colorList[
                                  index % Colorslist().colorList.length],
                            ),
                            child: Image.asset(
                              foodItem["img"],
                              width: 60,
                              height: 60,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            foodItem["food_item"],
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Detail(
                                    itemData: foodItem,
                                    category: widget.category,
                                    img: foodItem["img"],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 35,
                              width: 110,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(148, 171, 253, 1.0),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "View",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "Popular",
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.itemsData.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final foodItem = widget.itemsData[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFFF9FAFC), // Softer white background
                      boxShadow: [
                        BoxShadow(
                          color: Colors
                              .grey.shade300, // Darker shadow for more contrast
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colorslist()
                                .colorList[
                                    index % Colorslist().colorList.length]
                                .withOpacity(0.8),
                          ),
                          child: Image.asset(
                            foodItem["img"],
                            width: 65,
                            height: 65,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                foodItem["food_item"],
                                style: GoogleFonts.poppins(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(
                                      0xFF2C3E50), // Darker text for better readability
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${foodItem["calories"]} kcal", // Added "kcal" for clarity
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey
                                      .shade700, // Darker grey for readability
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Detail(
                                  itemData: foodItem,
                                  category: widget.category,
                                  img: foodItem["img"],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF94ABFD)
                                  .withOpacity(0.15), // Softer blue accent
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: const Color(
                                  0xFF5A6CFF), // Stronger blue for the icon
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
