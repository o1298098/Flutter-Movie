import 'package:flutter/gestures.dart';
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
  bool _disableScroll;
  ScrollController _scrollController;
  Tween<double> topTween;
  GlobalKey key;

  @override
  void initState() {
    _disableScroll = true;
    key = GlobalKey();
    _scrollController = ScrollController()
      ..addListener(_scrollControllerListener);
    isrun = false;
    _fontBackGroundColor = widget.frontBackGroundColor ?? Colors.white;
    topTween = Tween<double>(begin: widget.height, end: 0.0);
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(_animationControllerListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollControllerListener);
    _animationController.removeListener(_animationControllerListener);
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollControllerListener() {
    if (_scrollController.offset <= 0) {
      _disableScroll = _scrollController.offset <= 0;
    }
  }

  void _animationControllerListener() {
    if (_animationController.value == 1) {
      _disableScroll = false;
      _scrollController.animateTo(0.01,
          curve: Curves.easeOut, duration: const Duration(milliseconds: 100));
    }
  }

  void _pointMove(PointerMoveEvent d) {
    if (_scrollController.position.pixels == 0)
      _animationController.value -= d.delta.dy / widget.height;
  }

  void _pointUp(PointerUpEvent d) {
    if (_animationController.isAnimating) return;
    if (_scrollController.position.pixels != 0) return;
    double minFlingVelocity = (widget.height) / 4;

    if (d.localDelta.dy.abs() >= minFlingVelocity) {
      double visualVelocity = -d.delta.dy / widget.height;
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
  void didUpdateWidget(BackDrop oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.frontBackGroundColor != oldWidget.frontBackGroundColor)
      setState(() {
        _fontBackGroundColor = widget.frontBackGroundColor ?? Colors.white;
      });
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
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
              child: Listener(
                onPointerMove: _pointMove,
                onPointerUp: _pointUp,
                child: Column(
                  children: <Widget>[
                    Container(
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
                      width: _size.width,
                      height: 40,
                      child: Container(
                        width: 50,
                        height: 3,
                        color: const Color(0xFFE0E0E0),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: _fontBackGroundColor,
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(accentColor: Colors.transparent),
                          child: ListView.builder(
                            controller: _scrollController,
                            physics: _disableScroll
                                ? _neverScrollableScrollPhysics
                                : _clampingScrollPhysics,
                            itemBuilder: (_, index) =>
                                widget.frontChildren[index],
                            itemCount: widget.frontChildren?.length ?? 0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
