import 'dart:developer';

import 'package:fitlife/Dashboard/home_ui.dart';
import 'package:fitlife/main.dart';
import 'package:fitlife/widget/customSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomWaterBottomSheet extends StatefulWidget {
  @override
  _CustomWaterBottomSheetState createState() => _CustomWaterBottomSheetState();
}

class _CustomWaterBottomSheetState extends State<CustomWaterBottomSheet> {
  int liter = 0; // Initialize water intake to 0
  TextEditingController _increaseWaterIntakeContriller =
      TextEditingController();
  initState() {
    super.initState();
    // getTodayWaterIntake();
  }

  getTodayWaterIntake() async {
    liter = await MainApp().sqfliteObj?.getTodayWaterIntake();
    setState(() {});
  }

  void _increaseWaterIntake(int amount) {
    setState(() {
      liter += amount;
      log("$liter");
      MainApp().sqfliteObj?.insertOrUpdateWaterIntake(liter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              "Log Your Water Intake",
              style: GoogleFonts.poppins(
                  fontSize: 26, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(25),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey)),
              child: Column(
                children: [
                  Text(
                    "Total Volume",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "$liter ml",
                    style: GoogleFonts.poppins(
                        color: Colors.grey[400],
                        fontSize: 37,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Your Daily Goal: 2,500 ml",
              style: GoogleFonts.poppins(
                  fontSize: 17, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 50,
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
                              showSecondBottomSheet(context);
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
              height: 50,
            ),
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  if (liter != 0) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => HomeUi(
                                liter: liter,
                              )),
                    );
                    CustomSnackBar.customSnackBar(
                        context: context,
                        message: "Water Added succssefully ",
                        color: Colors.green);
                    log("Saved Button : $liter");
                    _increaseWaterIntakeContriller.clear();
                  }
                },
                child: Text(
                  "Save",
                  style: GoogleFonts.poppins(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
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
      ),
    );
  }

  void showSecondBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    'Add Water',
                    style: GoogleFonts.poppins(
                        fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        int textFieldIntake =
                            int.parse(_increaseWaterIntakeContriller.text);
                        _increaseWaterIntake(textFieldIntake);
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.check_circle_rounded,
                        color: Colors.green,
                        size: 45,
                      ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _increaseWaterIntakeContriller,
                decoration: InputDecoration(
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 4)),
                    hintText: 'Enter Water',
                    suffixText: "ml",
                    hintStyle: TextStyle(fontSize: 19)),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        );
      },
    );
  }
}
