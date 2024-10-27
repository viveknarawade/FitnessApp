import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dinner extends StatefulWidget {
  const Dinner({super.key});

  @override
  State createState() => _BreakfastState();
}

class _BreakfastState extends State {
  @override
  Widget build(context) {
    return ListView.builder(
      itemCount:5,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 17),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0,3)
                ),
              ],
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
