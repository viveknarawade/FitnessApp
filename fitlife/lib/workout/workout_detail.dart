// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class Workoutvedio extends StatefulWidget {
//   const Workoutvedio({super.key});

//   @override
//   State<Workoutvedio> createState() => _WorkoutvedioState();
// }

// class _WorkoutvedioState extends State<Workoutvedio> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _loadVideo();
//   }

//   // Function to load the downloaded video from local storage
//   Future<void> _loadVideo() async {
//     // Replace with the actual path where the video is stored
//     final videoPath = 'assets/tricep.mp4';

//     // Create a video controller with the local file
//     _controller = VideoPlayerController.asset(videoPath)
//       ..initialize().then((_) {
//         setState(() {});
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             title: const Text("Fullbody Workout"),
//             expandedHeight: 350,
//             backgroundColor: Colors.purpleAccent,
//             flexibleSpace: FlexibleSpaceBar(
//               background: _controller.value.isInitialized
//                   ? AspectRatio(
//                       aspectRatio: _controller.value.aspectRatio,
//                       child: VideoPlayer(_controller), // Display the video
//                     )
//                   : CircularProgressIndicator(), // Loading indicator
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:fitlife/workout/myTimeLine.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutDetail extends StatefulWidget {
  List<Map<String, dynamic>> tempexerciseData = [];
  WorkoutDetail({super.key, required this.tempexerciseData});

  @override
  State<WorkoutDetail> createState() => _WorkoutDetailState();
}

class _WorkoutDetailState extends State<WorkoutDetail> {
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
                  // Positioned(
                  //   top: 140,
                  //   child: Image.asset(
                  //     widget.specificImage,
                  //     height: 220,
                  //     width: 220,
                  //   ),
                  // ),
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
                    "food_item",
                    style: GoogleFonts.poppins(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 10),
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
                      "description",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "How  To Do It",
                    style: GoogleFonts.poppins(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  // Mytimeline(),
                  SizedBox(
                    height: 10,
                  ),
                   Text(
                    "Custom Repetitions",
                    style: GoogleFonts.poppins(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                   SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        // // Print the formatted time, date, and day
                        // log("Current Time: ${DateTimeDay().formattedTime}");
                        // log("Current Date: ${DateTimeDay().formattedDate}");
                        // log("Day of the Week: ${DateTimeDay().dayOfWeek}");
                        // widget.itemData.addAll(
                        //   {
                        //     "Time": "${DateTimeDay().formattedTime}",
                        //     "Date": " ${DateTimeDay().formattedDate}",
                        //     "Day": "${DateTimeDay().dayOfWeek}"
                        //   },
                        // );
                        // Map<String, String> weeklyCalories =
                        //     await CaloriesIntake().getWeeklyCaloriesData();

                        // print(widget.itemData);
                        // MealIntake()
                        //     .addMealData(widget.category, widget.itemData);

                        // CaloriesIntake()
                        //     .addDayCaloriesData(widget.itemData["calories"]);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromRGBO(148, 171, 253, 1.0),
                        ),
                        child: Text(
                          "Add to  Meal",
                          style: GoogleFonts.poppins(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
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
