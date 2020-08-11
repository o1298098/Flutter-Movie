import 'package:flutter/material.dart';

class BackDrop extends StatefulWidget {
  final Widget backChild;
  final List<Widget> frontChildren;
  final Color frontBackGroundColor;
  final double backLayerHeight;
  BackDrop({
    Key key,
    @required this.backChild,
    @required this.frontChildren,
    this.frontBackGroundColor,
    this.backLayerHeight = 0.0,
  }) : super(key: key);
  @override
  BackDropState createState() => BackDropState();
}

class BackDropState extends State<BackDrop> with TickerProviderStateMixin {
  GlobalKey key;
  final ClampingScrollPhysics _clampingScrollPhysics = ClampingScrollPhysics();
  @override
  void initState() {
    key = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(BackDrop oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    double _initialChildSize =
        1 - (widget.backLayerHeight / _mediaQuery.size.height);
    return Stack(
      children: <Widget>[
        Container(
          key: key,
          child: widget.backChild,
        ),
        DraggableScrollableSheet(
            initialChildSize: _initialChildSize,
            minChildSize: _initialChildSize,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                padding: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: widget.frontBackGroundColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(accentColor: Colors.transparent),
                  child: ListView.builder(
                    controller: scrollController,
                    physics: _clampingScrollPhysics,
                    itemBuilder: (_, index) => widget.frontChildren[index],
                    itemCount: widget.frontChildren?.length ?? 0,
                  ),
                ),
              );
            }),
      ],
    );
  }
}
