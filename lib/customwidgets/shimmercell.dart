import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCell extends StatelessWidget {
  const ShimmerCell(this.width, this.height, this.borderRadius,
      {Key key,
      this.margin = EdgeInsets.zero,
      this.baseColor = const Color(0xFFEEEEEE),
      this.highlightColor = const Color(0xFFF5F5F5)})
      : super(key: key);

  final double width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry margin;
  final Color baseColor;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
