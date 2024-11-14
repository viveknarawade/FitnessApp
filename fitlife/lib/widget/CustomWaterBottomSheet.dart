import 'package:fitlife/widget/customSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomWaterBottomSheet extends StatefulWidget {
  @override
  _CustomWaterBottomSheetState createState() => _CustomWaterBottomSheetState();
}

class _CustomWaterBottomSheetState extends State<CustomWaterBottomSheet> {
  int _liter = 0; // Initialize water intake to 0

  void _increaseWaterIntake(int amount) {
    setState(() {
      _liter += amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Text(
            "Log Your Water Intake",
            style:
                GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey)),
            child: Column(
              children: [
                Text(
                  "Total Volume",
                  style: GoogleFonts.poppins(
                      fontSize: 17, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "$_liter ml",
                  style: GoogleFonts.poppins(
                      color: Colors.grey[400],
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Your Daily Goal: 2,500 ml",
            style:
                GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Column(
            children: [
              Image.asset(
                "assets/bottomsheet/group.png",
                width: 370,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "250 ml",
                          style: GoogleFonts.poppins(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        GestureDetector(
                          onTap: () => _increaseWaterIntake(250),
                          child: Icon(
                            Icons.add,
                            color: Colors.blue,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Column(
                      children: [
                        Text(
                          "500 ml",
                          style: GoogleFonts.poppins(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        GestureDetector(
                          onTap: () => _increaseWaterIntake(500),
                          child: Icon(
                            Icons.add,
                            color: Colors.blue,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Column(
                      children: [
                        Text(
                          "1000 ml",
                          style: GoogleFonts.poppins(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        GestureDetector(
                          onTap: () => _increaseWaterIntake(1000),
                          child: Icon(
                            Icons.add,
                            color: Colors.blue,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 80,
                          child: Text(
                            "Custom Amount",
                            style: GoogleFonts.poppins(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 37,
                        ),
                        GestureDetector(
                          onTap: () {
                            CustomSnackBar.customSnackBar(
                                context: context,
                                message: "Add Water",
                                color: Colors.amber);
                              
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.blue,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 150,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "Save",
                style: GoogleFonts.poppins(fontSize: 17, color: Colors.black),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class CustomWaterBottomSheetHelper {
  static showWaterLevelBottomsheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CustomWaterBottomSheet(); // Return StatefulWidget instead of static method
      },
    );
  }
}
