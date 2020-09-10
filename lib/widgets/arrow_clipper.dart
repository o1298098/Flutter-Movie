import 'package:flutter/material.dart';

class ArrowClipper extends CustomClipper<Path> {
  final String mode;
  const ArrowClipper({this.mode = 'down'});
  @override
  Path getClip(Size size) {
    Path path = Path();
    switch (mode) {
      case 'up':
        path.moveTo(size.width / 2, 0);
        path.lineTo(size.width, size.height / 2);
        path.lineTo(0, size.height / 2);
        break;
      case 'down':
        path.moveTo(0, 0);
        path.lineTo(size.width, 0);
        path.lineTo(size.width / 2, size.height / 2);
        break;
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
