import 'dart:async'; // For the Timer class
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'workoutfinish.dart';
import 'workoutSet.dart';

class StartExercise extends StatefulWidget {
  final List<Map<String, dynamic>> exerciseCardData;
  final String workoutTypeName;

  StartExercise({
    Key? key,
    required this.exerciseCardData,
    required this.workoutTypeName,
  }) : super(key: key);

  @override
  State<StartExercise> createState() => _StartExerciseState();
}

class _StartExerciseState extends State<StartExercise> {
  late Timer _timer;
  int _seconds = 0; // Timer count in seconds

  String _formattedTime = "00:00"; // Time display in MM:SS format

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start the timer as soon as the screen is loaded
  }

  // Start the timer
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
        _formattedTime = _formatTime(_seconds); // Update the time every second
      });
    });
  }

  // Stop the timer
  void _stopTimer() {
    _timer.cancel(); // This stops the periodic timer
  }

  // Format seconds to MM:SS format
  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60; // Get the number of minutes
    int remainingSeconds = seconds % 60; // Get the remaining seconds
    return "${_padZero(minutes)}:${_padZero(remainingSeconds)}";
  }

  // Pad single digits with leading zero for proper format (MM:SS)
  String _padZero(int number) {
    return number.toString().padLeft(2, '0');
  }

  @override
  void dispose() {
    _stopTimer(); // Stop the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Workout Details"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  _stopTimer(); // Stop the timer when workout is finished
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return Finish();
                      },
                    ),
                  );
                },
                child: const Text(
                  "Finish",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.workoutTypeName + " Workout",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Displaying the timer
            Text(
              _formattedTime,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Expanded(
                child: Workoutset(
              exerciseCardData: widget.exerciseCardData,
            )),
            Center(
              child: GestureDetector(
                onTap: () {
                  _stopTimer(); // Stop the timer when workout is canceled
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10, right: 24),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "Cancel Workout",
                    style:
                        GoogleFonts.poppins(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
