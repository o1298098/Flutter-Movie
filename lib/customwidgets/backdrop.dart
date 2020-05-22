import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';

class BackDrop extends StatefulWidget {
  final Widget backChild;
  final List<Widget> frontChildren;
  final Color frontBackGroundColor;
  final double height;
  BackDrop(
      {Key key,
      @required this.backChild,
      @required this.frontChildren,
      this.frontBackGroundColor,
      this.height = 0.0})
      : super(key: key);
  @override
  BackDropState createState() => BackDropState();
}

class BackDropState extends State<BackDrop> with TickerProviderStateMixin {
  bool isrun;
  AnimationController _animationController;
  Color _fontBackGroundColor;
  final ClampingScrollPhysics _clampingScrollPhysics = ClampingScrollPhysics();
  final NeverScrollableScrollPhysics _neverScrollableScrollPhysics =
      NeverScrollableScrollPhysics();
  ScrollController _scrollController;
  Tween<double> topTween;
  GlobalKey key;
  @override
  void initState() {
    key = GlobalKey();
    _scrollController = ScrollController();
    isrun = false;
    _fontBackGroundColor = widget.frontBackGroundColor ?? Colors.white;
    topTween = Tween<double>(begin: widget.height, end: 0.0);
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            if (_animationController.value == 0 &&
                _scrollController.position.pixels != 0)
              _scrollController.animateTo(0,
                  duration: Duration(milliseconds: 300), curve: Curves.ease);
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
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(BackDrop oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.frontBackGroundColor != oldWidget.frontBackGroundColor)
      setState(() {
        _fontBackGroundColor = widget.frontBackGroundColor ?? Colors.white;
      });
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
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onVerticalDragUpdate: _drag,
                    onVerticalDragEnd: _dragEnd,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _fontBackGroundColor,
                        border:
                            Border.all(width: 0.0, color: _fontBackGroundColor),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Adapt.px(40)),
                          topRight: Radius.circular(Adapt.px(40)),
                        ),
                      ),
                      width: Adapt.screenW(),
                      height: Adapt.px(80),
                      child: Container(
                        width: Adapt.px(80),
                        height: Adapt.px(6),
                        color: const Color(0xFFE0E0E0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: _fontBackGroundColor,
                      child: ListView.builder(
                        controller: _scrollController,
                        physics: _animationController.value == 0
                            ? _neverScrollableScrollPhysics
                            : _clampingScrollPhysics,
                        itemBuilder: (_, index) => widget.frontChildren[index],
                        itemCount: widget.frontChildren?.length ?? 0,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
