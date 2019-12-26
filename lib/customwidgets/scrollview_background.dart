import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrollViewBackGround extends StatefulWidget {
  final double height;
  final ScrollController scrollController;
  final double maxOpacity;
  final Widget child;
  ScrollViewBackGround(
      {Key key,
      this.child,
      this.scrollController,
      this.height,
      this.maxOpacity})
      : super(key: key);
  @override
  ScrollViewBackGroundState createState() => ScrollViewBackGroundState();
}

class ScrollViewBackGroundState extends State<ScrollViewBackGround> {
  double op;
  void _scrolllistener() {
    double o = widget.scrollController.position.pixels / widget.height;
    if (o > widget.maxOpacity) o = widget.maxOpacity;
    setState(() {
      op = o;
    });
  }

  @override
  void initState() {
    op = 0.0;
    widget.scrollController.addListener(_scrolllistener);

    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrolllistener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(op),
      child: widget.child,
    );
  }
}
