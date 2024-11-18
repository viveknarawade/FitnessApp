import 'dart:developer';

import 'package:fitlife/Meal_Planner/mealCategory.dart';
import 'package:fitlife/Meal_Planner/mealDetail.dart';
import 'package:fitlife/Meal_Planner/mealHome.dart';
import 'package:fitlife/widget/colorsList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomListview extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  String? categories;

  CustomListview({super.key, required this.data, required this.categories});

  @override
  State<CustomListview> createState() => _CustomListviewState();
}

class _CustomListviewState extends State<CustomListview> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.data.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final meal = widget.data[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 17),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: GestureDetector(
            onTap: () {
              log("${widget.data[0]}");
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Detail(
                      itemData: widget.data[0],
                      category: widget.categories!,
                      img: "img",
                    );
                  },
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colorslist().colorList[
                                    index % Colorslist().colorList.length],
                              ),
                              child: Image.asset(
                                meal["img"],
                                width:40,
                                height:40,
                              ),
                            ),
                    const SizedBox(width: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meal['food_item'],
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${meal['Day']} | ${meal['Time']}",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                SvgPicture.asset(
                  "assets/icon/Button-Next.svg",
                  width: 30,
                  height: 33,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
