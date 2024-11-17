import 'dart:developer';

import 'package:fitlife/Firebase/Storage/exerciseData.dart';
import 'package:fitlife/workout/exerciseCard.dart';
import 'package:fitlife/workout/startExercise.dart';
import 'package:fitlife/workout/workoutSchedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class workoutType extends StatefulWidget {
  List<Map<String, dynamic>> exerciseCardData = [];
  String workoutTypeName;
  workoutType(
      {super.key,
      required this.exerciseCardData,
      required this.workoutTypeName});

  @override
  State<workoutType> createState() => _FullbodyState();
}

class _FullbodyState extends State<workoutType> {
  List<Map<String, dynamic>> tempexerciseData = [];
  storeData() async {
    tempexerciseData =
        await ExerciseStorage().getExerciseData(widget.workoutTypeName);
    // Print the result for debugging purposes
    log("tempexerciseData = $tempexerciseData");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    log("in initState ");
    storeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color.fromRGBO(148, 171, 253, 1.0),
            expandedHeight: MediaQuery.of(context).size.width * 0.8,
            elevation: 0.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 100, left: 65),
                    alignment: Alignment.center,
                    height: 270,
                    width: 280,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(183, 206, 254, 0.5),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 10,
                    child: Image.asset(
                      "assets/workout/fullBody-navs.png",
                      height: 400,
                      width: 400,
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
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.workoutTypeName + "  Workout",
                    style: GoogleFonts.poppins(
                        fontSize: 23, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    margin: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromRGBO(233, 237, 255, 1)
                    ),
                    child: GestureDetector(
                      

                      onTap: (){
                          
                        Navigator.push(
                          context,MaterialPageRoute(builder: (context){
                          return  Workoutschedule();

                          })
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset("assets/icon/Calendar.svg",width: 18,height: 27,),
                          Text("Schedule Workout     5/27, 9:00 AM",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w400),),
                          Icon(Icons.arrow_forward_ios,color: Colors.grey)
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "Exercises",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          Exercisecard(
            tempexerciseData: tempexerciseData,
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 280, // Adjust width to fit the text comfortably
        height: 50, // Adjust height as needed
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(
                148, 171, 253, 1.0), // Customize the background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24), // Customize shape
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return StartExercise(
                    exerciseCardData: tempexerciseData,
                    workoutTypeName: widget.workoutTypeName,
                  );
                },
              ),
            );
          },
          child: Text("Start Workout",
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700) // Customize text style
              ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat, // Position as needed
    );
  }
}
