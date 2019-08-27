import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCell extends StatelessWidget {
  const ShimmerCell(this.width, this.height, this.borderRadius,
      {Key key, this.margin = EdgeInsets.zero})
      : super(key: key);

  final double width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200],
      highlightColor: Colors.grey[100],
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
