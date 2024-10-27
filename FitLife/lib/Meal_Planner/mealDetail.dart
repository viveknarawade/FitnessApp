import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final nutritionData = [
    {"icon": "assets/icon/calories.svg", "label": "Calories"},
    {"icon": "assets/icon/protein.svg", "label": "Protein"},
    {"icon": "assets/icon/carbs.svg", "label": "Carbs"},
    {"icon": "assets/icon/fat.svg", "label": "Fat"},
  ];

  @override
  Widget build(BuildContext context) {
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
                    child: SvgPicture.asset(
                      "assets/meal/pancake1.svg",
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
                    "Blueberry Pancake",
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
                    children: [
                      for (int i = 0; i < nutritionData.length; i++)
                        Expanded(
                          child: Container(
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
                                SvgPicture.asset(
                                  nutritionData[i]["icon"]!,
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  nutritionData[i]["label"]!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
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
                      "Pancakes are a breakfast favorite for many – who doesn’t love a stack of fluffy pancakes, especially with a drizzle of real honey cascading over the top? Of course, everyone enjoys that! Besides being delicious, pancakes can also be...",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Center(
                    child: Container(

                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color.fromRGBO(148, 171, 253, 1.0),
                      ),
                      child: Text(
                        "Add to Breakfast Meal",
                        style: GoogleFonts.poppins(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
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
