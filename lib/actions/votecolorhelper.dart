import 'package:flutter/material.dart';

class VoteColorHelper {
  static Color getColor(double s) {
    Color r = Colors.red;
    if (s > 4.5 && s < 7)
      r = Colors.yellow;
    else if (s >= 7) r = Colors.green;
    return r;
  }
}
