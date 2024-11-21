import 'dart:developer';

import 'package:fitlife/Dashboard/home_ui.dart';
import 'package:fitlife/Firebase/Firestore/workout/calories_burn.dart';
import 'package:fitlife/Firebase/Firestore/workout/workout_calories.dart';
import 'package:fitlife/widget/customAlertDemo.dart';
import 'package:fitlife/workout/myTimeLine.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class WorkoutDetail extends StatefulWidget {
  String exerciseName;
  String rep;
  String description;
  String workoutTypeName;
  WorkoutDetail({
    super.key,
    required this.exerciseName,
    required this.rep,
    required this.description,
    required this.workoutTypeName,
  });

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
      backgroundColor: const Color(0xFFF4F7FE), // Soft background color
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFF5D7AEA), // Deep periwinkle blue
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
                  : const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Container(
                height: 50.0,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: const Color(0xFFF4F7FE),
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
                    color: const Color(0xFFE0E0E0), // Soft gray
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
                  // Exercise Name
                  Text(
                    widget.exerciseName,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Repetitions
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F7FE),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.repeat_rounded,
                            color: const Color(0xFF5D7AEA)),
                        const SizedBox(width: 10),
                        Text(
                          widget.rep,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF666666),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Description Section
                  Text(
                    "Description",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F7FE),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      widget.description,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF666666),
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Custom Repetition Section
                  Text(
                    "Custom Repetition",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F7FE),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: SizedBox(
                      height: 150,
                      child: ListWheelScrollView.useDelegate(
                        controller: _controller,
                        itemExtent: 60,
                        physics: const FixedExtentScrollPhysics(),
                        perspective: 0.002,
                        onSelectedItemChanged: (index) {
                          setState(() {
                            selectedIndex =
                                calculateCaloriesBurned(times[index]);
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
                                    '${calculateCaloriesBurned(times[index])} Calories',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: const Color(0xFF666666),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    '${times[index]} min',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: const Color(0xFF666666),
                                      fontWeight: FontWeight.w500,
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
                  ),
                  const SizedBox(height: 25),

                  // Save Button
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          log("Calories burned = $selectedIndex");
                          await CaloriesBurn()
                              .addDayBurnCaloriesData(selectedIndex.toString());
                          await WorkoutCalories().addWorkoutData(
                            widget.workoutTypeName,
                            {
                              "WorkoutName": widget.exerciseName,
                              "burn": selectedIndex,
                            },
                          );
                          CustomAlertBoxDemo().showMyDialog(
                            context,
                            "${widget.exerciseName} Completed",
                          );
                          setState(() {});
                        } catch (e) {
                          log("Error saving workout data: $e");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Error saving data. Please try again."),
                            ),
                          );
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 130, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color:
                              const Color(0xFF5D7AEA), // Deep periwinkle blue
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF5D7AEA).withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Text(
                          "Save",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
