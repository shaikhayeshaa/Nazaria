import 'package:flutter/material.dart';

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height - 60); // Bottom left
    path.quadraticBezierTo(
      size.width / 2, size.height, // Control point
      size.width, size.height - 60, // End point
    );
    path.lineTo(size.width, 0); // Top right
    path.close(); // Close the path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
