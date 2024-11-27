import 'dart:developer';
import 'package:fitlife/Meal_Planner/mealDetail.dart';
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
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.data.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final meal = widget.data[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
          child: Card(
            color: Colors.lightBlue[50],
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              onTap: () {
                log("${widget.data[0]}");
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Detail(
                      itemData: widget.data[index],
                      category: widget.categories!,
                      img: "img",
                    ),
                  ),
                );
              },
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colorslist()
                      .colorList[index % Colorslist().colorList.length],
                ),
                child: Image.asset(
                  widget.data[index]["img"],
                  width: 40,
                  height: 40,
                ),
              ),
              title: Text(
                meal['food_item'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "${meal['Day']} | ${meal['Time']}",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
              trailing: SvgPicture.asset(
                "assets/icon/Button-Next.svg",
                width: 30,
                height: 33,
              ),
            ),
          ),
        );
      },
    );
  }
}
