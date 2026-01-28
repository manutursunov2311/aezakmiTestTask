import 'package:flutter/cupertino.dart';

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Start at bottom left
    path.lineTo(0, size.height);
    // Go to top middle (the tip)
    path.lineTo(size.width / 2, 0);
    // Go to bottom right
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}