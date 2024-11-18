import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  final String videoPath;
  const VideoApp({super.key, required this.videoPath});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController? _controller;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() async {
    try {
      _controller = VideoPlayerController.asset(widget.videoPath);
      
      await _controller!.initialize();
      
      _controller!.addListener(() {
        if (_controller!.value.hasError) {
          setState(() {
            _errorMessage = 'Video initialization error';
            _isLoading = false;
          });
        }
      });

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading video: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: _buildVideoPlayer(),
        ),
        floatingActionButton: _buildPlayPauseButton(),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (_isLoading) {
      return const CircularProgressIndicator();
    }

    if (_errorMessage != null) {
      return Text(_errorMessage!, style: const TextStyle(color: Colors.red));
    }

    if (_controller == null || !_controller!.value.isInitialized) {
      return const Text('Video could not be loaded');
    }

    return AspectRatio(
      aspectRatio: _controller!.value.aspectRatio,
      child: VideoPlayer(_controller!),
    );
  }

  Widget? _buildPlayPauseButton() {
    if (_controller == null || !_controller!.value.isInitialized) {
      return null;
    }

    return FloatingActionButton(
      onPressed: () {
        setState(() {
          _controller!.value.isPlaying 
              ? _controller!.pause() 
              : _controller!.play();
        });
      },
      child: Icon(
        _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

// Usage example
class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const VideoApp(videoPath: 'assets/video/push_up.mp4');
  }
}