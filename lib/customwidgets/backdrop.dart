import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';

class BackDrop extends StatefulWidget {
  final Widget backChild;
  final Widget frontChild;
  final double height;
  BackDrop({this.backChild, this.frontChild, this.height});
  @override
  BackDropState createState() => BackDropState();
}

class BackDropState extends State<BackDrop> with TickerProviderStateMixin {
  double dropHeight;
  double _startHeight = 0;
  double _stratY;
  double _positionY;
  double _lastDeffY = 0;
  double _top = 0;
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
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    dropHeight = widget.height ?? 0.0;
    _startHeight = widget.height ?? 0.0;
    super.initState();
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
                top: topTween
                    .animate(CurvedAnimation(
                        parent: _animationController, curve: Curves.ease))
                    .value,
                child: Column(children: <Widget>[
                  GestureDetector(
                    /*onVerticalDragUpdate: (dragUpdateDetails) {
                      if (_positionY == null) {
                        RenderBox box = key.currentContext.findRenderObject();
                        Offset position = box.localToGlobal(Offset.zero);
                        _positionY = position.dy;
                      }
                      _lastDeffY =
                          _stratY - dragUpdateDetails.globalPosition.dy;
                      print(dragUpdateDetails.globalPosition);
                      var _movie =
                          dragUpdateDetails.globalPosition.dy - _positionY;
                      if (_movie > 0.0 && _movie <= _startHeight) {
                        _top = _movie;
                      } else if (_top < 0)
                        _top = 0.0;
                      else if (_top > _startHeight) _top = _startHeight;
                      setState(() {
                        dropHeight = _top;
                      });
                    },
                    onVerticalDragStart: (d) {
                      _lastDeffY = 0;
                      _stratY = d.globalPosition.dy;
                    },
                    onVerticalDragEnd: (d) async {
                      if (_lastDeffY == 0) return;
                      if (_lastDeffY > 0) {
                        setState(() {
                          _animationController.value =
                              (_startHeight - dropHeight) / _startHeight;
                          isrun = true;
                        });

                        await _animationController.forward().then((f) {
                          setState(() {
                            dropHeight = 0.0;
                            isrun = false;
                          });
                        });
                      } else if (_lastDeffY < 0) {
                        setState(() {
                          _animationController.value =
                              (_startHeight - dropHeight) / _startHeight;
                          isrun = true;
                        });

                        await _animationController.reverse().then((f) {
                          setState(() {
                            dropHeight = _startHeight;
                            isrun = false;
                          });
                        });
                      }
                    },*/
                    onTap: () {
                      if (_animationController.value == 0.0)
                        _animationController.forward();
                      else
                        _animationController.reverse();
                    },
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
