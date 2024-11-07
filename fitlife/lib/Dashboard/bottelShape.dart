import 'package:flutter/material.dart';

class BottleShape {
  // Method to get the bottle path
  Path getPath(Size size) {
    Path path = Path();

    double width = size.width;
    double height = size.height;

    // Start from the bottom-left corner of the bottle
    path.moveTo(0, height * 0.9);  // Rounded bottom
    path.quadraticBezierTo(width * 0.05, height, width * 0.15, height);  // Bottom left curve
    path.lineTo(width * 0.85, height);  // Straight across the bottom
    path.quadraticBezierTo(width * 0.95, height, width, height * 0.9);  // Bottom right curve

    // Right side of the bottle body
    path.lineTo(width, height * 0.5);  // Straight up the right side

    // Now define the neck of the bottle
    path.quadraticBezierTo(width * 0.98, height * 0.4, width * 0.7, height * 0.35);  // Right neck curve
    path.lineTo(width * 0.7, height * 0.25);  // Top-right neck container side
    path.lineTo(width * 0.3, height * 0.25);  // Straight across the top (container-like)
    path.lineTo(width * 0.3, height * 0.35);  // Left neck straight line
    path.quadraticBezierTo(width * 0.02, height * 0.4, 0, height * 0.5);  // Left side neck curve

    // Left side of the bottle body
    path.lineTo(0, height * 0.9);  // Back down to the start

    path.close();
    return path;
  }
}
