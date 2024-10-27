import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Breakfast extends StatefulWidget {
  const Breakfast({super.key});

  @override
  State createState() => _BreakfastState();
}

class _BreakfastState extends State {
  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: 8,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 14,
                  offset: Offset(0, 5),
                  spreadRadius: 5,
                  blurStyle: BlurStyle.outer,
                )
              ]),
          child: Row(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/meal/pancakes.svg",
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(width: 19),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "cake",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "120 cal",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    "assets/icons/next-btn.svg",
                    height: 30,
                    width: 30,
                  )),
              const SizedBox(width: 10),
            ],
          ),
        );
      },
    );
  }
}
