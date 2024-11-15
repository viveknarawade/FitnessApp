import 'package:fitlife/Firebase/Storage/foodData.dart';
import 'package:fitlife/Meal_Planner/mealDetail.dart';
import 'package:fitlife/Meal_Planner/mealHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Category extends StatefulWidget {
  String category;
  List<Map<String, dynamic>> itemsData;
  List foodImages;
  // Constructor to accept the selected category and item data
  Category({super.key, required this.category, required this.itemsData, required this.foodImages});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    print("${widget.itemsData.length}");

    return Scaffold(
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
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromRGBO(234, 239, 254, 1.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          "assets/meal/pancakes.svg",
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(height: 9),
                        Text(
                          foodItem["food_item"],
                          style: GoogleFonts.poppins(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Detail(
                                  itemData: foodItem,
                                  category: widget.category,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 30,
                            width: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(148, 171, 253, 1.0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "View",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
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
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
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
                      ],
                    ),
                    child: Row(
                      children: [
                        Row(
                          children: [
                           Image.asset(widget.foodImages[index],width: 60,height: 60,),
                            const SizedBox(width: 19),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  foodItem["food_item"],
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  foodItem["calories"],
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
                            onTap: () {
                              print(foodItem);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Detail(
                                      itemData: foodItem,
                                      category: widget.category,
                                    );
                                  },
                                ),
                              );
                            },
                            child: SvgPicture.asset(
                              "assets/icon/Button-Next.svg",
                              height: 30,
                              width: 30,
                            )),
                        const SizedBox(width: 10),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
