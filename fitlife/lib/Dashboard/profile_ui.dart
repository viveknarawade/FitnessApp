import 'dart:developer';

import 'package:fitlife/Authentication/login.dart';
import 'package:fitlife/Authentication/signUp.dart';
import 'package:fitlife/Firebase/Firestore/User/auth.dart';
import 'package:fitlife/Model/user.dart';
import 'package:fitlife/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileUi extends StatefulWidget {
  @override
  State createState() => _ProfileUiState();
}

class _ProfileUiState extends State<ProfileUi> {
  List displayData = [];

  addDataToList() async {
    displayData = await MainApp().sqfliteObj?.getData();
    log("DISPLAY : $displayData");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addDataToList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(247, 247, 247, 1),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("Profile"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${displayData[0]['USERNAME']}",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          Text(
                            "${displayData[0]['GOAL']}",
                            style: TextStyle(
                                color: Color.fromRGBO(123, 111, 114, 1),
                                fontSize: 15),
                          ),
                          Text(
                            " Program",
                            style: TextStyle(
                                color: Color.fromRGBO(123, 111, 114, 1),
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        "Edit",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 120,
                      height: 100,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(vertical: 19, horizontal: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(254, 254, 254, 1),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${displayData[0]["HEIGHT"]} Cm",
                            style: TextStyle(
                              color: Color.fromRGBO(151, 183, 254, 1),
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Height",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(123, 111, 114, 1),
                            ),
                          ),
                        ],
                      )),
                  Container(
                      width: 120,
                      height: 100,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(vertical: 19, horizontal: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(254, 254, 254, 1),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${displayData[0]['WEIGHT']} Kg",
                            style: TextStyle(
                              color: Color.fromRGBO(151, 183, 254, 1),
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Weight",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(123, 111, 114, 1),
                            ),
                          ),
                        ],
                      )),
                  Container(
                      width: 120,
                      height: 100,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(vertical: 19, horizontal: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(254, 254, 254, 1),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${displayData[0]['AGE']}",
                            style: TextStyle(
                              color: Color.fromRGBO(151, 183, 254, 1),
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Age",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(123, 111, 114, 1),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 19, horizontal: 23),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromRGBO(254, 254, 254, 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Account",
                      style: GoogleFonts.poppins(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My Goal",
                          style: GoogleFonts.poppins(
                              color: Color.fromRGBO(123, 111, 114, 1),
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color.fromRGBO(123, 111, 114, 1),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Change Passwoard",
                          style: GoogleFonts.poppins(
                              color: Color.fromRGBO(123, 111, 114, 1),
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color.fromRGBO(123, 111, 114, 1),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Appearace",
                          style: GoogleFonts.poppins(
                              color: Color.fromRGBO(123, 111, 114, 1),
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color.fromRGBO(123, 111, 114, 1),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        MainApp().sqfliteObj?.deleteData(displayData[0]["ID"]);

                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) {
                              return Login();
                            },
                          ),
                          (route) => false, // This removes all previous routes
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Log Out",
                            style: GoogleFonts.poppins(
                                color: Color.fromRGBO(123, 111, 114, 1),
                                fontSize: 19,
                                fontWeight: FontWeight.w500),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromRGBO(123, 111, 114, 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 19, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromRGBO(254, 254, 254, 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notification",
                      style: GoogleFonts.poppins(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Pop- up Notification",
                          style: GoogleFonts.poppins(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(123, 111, 114, 1),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
