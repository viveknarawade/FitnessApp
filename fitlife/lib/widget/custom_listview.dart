import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomListview extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  const CustomListview({super.key, required this.data});

  @override
  State<CustomListview> createState() => _CustomListviewState();
}

class _CustomListviewState extends State<CustomListview> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    log("CustomListview = ${widget.data}");
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
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 17),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(width: 10),
                  SvgPicture.asset(
                    "assets/meal/meal1.svg",
                    width: 40,
                    height: 40,
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
        );
      },
    );
  }
}
