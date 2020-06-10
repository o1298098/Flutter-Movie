import 'package:flutter/material.dart';

class VoteColorHelper {
  static Color getColor(double s) {
    Color r = const Color(0xFFFB5B3A);
    if (s > 4.5 && s < 7)
      r = const Color(0xFFF5AD6F);
    else if (s >= 7) r = const Color(0xFF68C790);
    return r;
  }
}
