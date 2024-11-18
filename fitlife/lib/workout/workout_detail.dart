import 'dart:developer';

import 'package:fitlife/Firebase/Firestore/workout/calories_burn.dart';
import 'package:fitlife/Firebase/Firestore/workout/workout_calories.dart';
import 'package:fitlife/workout/myTimeLine.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class WorkoutDetail extends StatefulWidget {
  String exerciseName;
  String rep;
  String description;
  String workoutTypeName;
  WorkoutDetail(
      {super.key,
      required this.exerciseName,
      required this.rep,
      required this.description,
      required this.workoutTypeName});

  @override
  State<WorkoutDetail> createState() => _WorkoutDetailState();
}

class _WorkoutDetailState extends State<WorkoutDetail> {
  // List of times from 0 to 60 minutes.
  final List<int> times = List.generate(61, (index) => index);

  // Scroll controller to track the selected index.
  final FixedExtentScrollController _controller = FixedExtentScrollController();

  int selectedIndex = 0;
  VideoPlayerController? _videoController;

  // Function to calculate calories burned based on time.
  int calculateCaloriesBurned(int time) {
    // Assuming 7 calories burned per minute for demonstration purposes.
    return time * 7;
  }

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() async {
    _videoController = VideoPlayerController.asset('assets/video/tricep.mp4')
      ..initialize().then((_) {
        setState(() {});
        _videoController!.setLooping(false); // Disable infinite looping
      });
  }

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
              background: _videoController != null &&
                      _videoController!.value.isInitialized
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _videoController!.value.isPlaying
                              ? _videoController!.pause()
                              : _videoController!.play();
                        });
                      },
                      child: AspectRatio(
                        aspectRatio: _videoController!.value.aspectRatio,
                        child: VideoPlayer(_videoController!),
                      ),
                    )
                  : const Center(child: CircularProgressIndicator()),
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
                    widget.exerciseName,
                    style: GoogleFonts.poppins(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.rep,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
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
                      widget.description,
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
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 150,
                          child: ListWheelScrollView.useDelegate(
                            controller: _controller,
                            itemExtent: 60, // Reduced space between items.
                            physics: FixedExtentScrollPhysics(),
                            perspective: 0.002,
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedIndex = calculateCaloriesBurned(
                                    times[index]); // Update selected index.
                              });
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                              builder: (context, index) {
                                return Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.local_fire_department,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        '${calculateCaloriesBurned(times[index])} Calories Burn',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        '${times[index]} min',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              childCount: times.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        log("calories burn = $selectedIndex");
                        CaloriesBurn()
                            .addDayBurnCaloriesData(selectedIndex.toString());
                        WorkoutCalories().addWorkoutData(
                            widget.workoutTypeName, {
                          "WorkoutName": widget.exerciseName,
                          "burn": selectedIndex
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromRGBO(148, 171, 253, 1.0),
                        ),
                        child: Text(
                          "Save",
                          style: GoogleFonts.poppins(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }
}
