import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Workoutvedio extends StatefulWidget {
  const Workoutvedio({super.key});

  @override
  State<Workoutvedio> createState() => _WorkoutvedioState();
}

class _WorkoutvedioState extends State<Workoutvedio> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  // Function to load the downloaded video from local storage
  Future<void> _loadVideo() async {
    // Replace with the actual path where the video is stored
    final videoPath = 'assets/tricep.mp4';

    // Create a video controller with the local file
    _controller = VideoPlayerController.asset(videoPath)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text("Fullbody Workout"),
            expandedHeight: 350,
            backgroundColor: Colors.purpleAccent,
            flexibleSpace: FlexibleSpaceBar(
              background: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller), // Display the video
                    )
                  : CircularProgressIndicator(), // Loading indicator
            ),
          ),
        ],
      ),
    );
  }
}
