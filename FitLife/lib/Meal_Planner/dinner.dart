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
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 1,  // Adjust based on your data
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(234, 238, 255, 1),
                  ),
                  child: SvgPicture.asset("assets/img/meal1.svg"),
                ),
                const SizedBox(width: 30),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Honey Pancake"),
                    Text("07:00 AM"),
                  ],
                ),
              ],
            ),
            SvgPicture.asset(
              "assets/icons/next-btn.svg",
              width: 40,
              height: 35,
            ),
          ],
        );
      },
    );
  }
}
