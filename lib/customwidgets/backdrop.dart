import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';

class BackDrop extends StatefulWidget {
  final Widget backChild;
  final Widget frontChild;
  final double height;
  BackDrop(
      {Key key,
      @required this.backChild,
      @required this.frontChild,
      this.height = 0.0})
      : super(key: key);
  @override
  BackDropState createState() => BackDropState();
}

class BackDropState extends State<BackDrop> with TickerProviderStateMixin {
  bool isrun;
  AnimationController _animationController;

  Tween<double> topTween;
  GlobalKey key;
  @override
  void initState() {
    key = GlobalKey();
    isrun = false;
    topTween = Tween<double>(begin: widget.height, end: 0.0);
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          });
    super.initState();
  }

  void _drag(DragUpdateDetails d) {
    _animationController.value -= d.primaryDelta / widget.height;
  }

  void _dragEnd(DragEndDetails d) {
    double minFlingVelocity = (widget.height) / 4;
    if (_animationController.isAnimating) return;
    if (d.velocity.pixelsPerSecond.dy.abs() >= minFlingVelocity) {
      double visualVelocity = -d.velocity.pixelsPerSecond.dy / widget.height;
      _animationController.fling(velocity: visualVelocity);
      return;
    }
    if (_animationController.value > 0.5) {
      _animationController.fling();
    } else {
      _animationController.fling(velocity: -1.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          key: key,
          child: widget.backChild,
        ),
        AnimatedBuilder(
          animation: _animationController,
          builder: (ctx, child) {
            return Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                top: (1 - _animationController.value) * widget.height,
                child: Column(children: <Widget>[
                  GestureDetector(
                    onVerticalDragUpdate: _drag,
                    onVerticalDragEnd: _dragEnd,
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 0.0, color: Colors.white),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(Adapt.px(40)),
                                topRight: Radius.circular(Adapt.px(40)))),
                        width: Adapt.screenW(),
                        height: Adapt.px(80),
                        child: Container(
                            width: Adapt.px(80),
                            height: Adapt.px(6),
                            color: Colors.grey[300])),
                  ),
                  Expanded(
                    child: widget.frontChild,
                  )
                ]));
          },
        )
      ],
    );
  }
}
