import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomWaterBottomSheet {
  static showWaterLevelBottomsheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Log Your water Intake",
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.w500),
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
                        "0 ml",
                        style: GoogleFonts.poppins(
                            color: Colors.grey[400],
                            fontSize: 30,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Your Daily Goal : 2,500",
                  style: GoogleFonts.poppins(
                      fontSize: 17, fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset("assets/bottomsheet/cup.png",
                        width: 100, height: 100, color: Colors.blue),
                    Image.asset(
                      "assets/bottomsheet/glass.png",
                      width: 150,
                      height: 120,
                      color: Colors.blue,
                    ),
                    Image.asset(
                      "assets/bottomsheet/bottle.png",
                      width: 100,
                      height: 200,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.add, color: Colors.blue),
                    Icon(Icons.add, color: Colors.blue),
                    Icon(
                      Icons.add,
                      color: Colors.blue,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Save",
                      style: GoogleFonts.poppins(
                          fontSize: 17, color: Colors.black),
                    ),
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                  ),
                ),
                SizedBox(height: 10,),

              ],
            ),
          );
        });
  }
}
