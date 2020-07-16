import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/widgets/sliverappbar_delegate.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    DiscoverPageState state, Dispatch dispatch, ViewService viewService) {
  final _adapter = viewService.buildAdapter();

  return Builder(
    builder: (context) {
      final ThemeData _theme = ThemeStyle.getTheme(context);

      return Scaffold(
        key: state.scaffoldKey,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: _theme.brightness == Brightness.light
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light,
          child: SafeArea(
            child: CustomScrollView(
              controller: state.scrollController,
              slivers: <Widget>[
                SliverPersistentHeader(
                  floating: true,
                  delegate: SliverAppBarDelegate(
                      minHeight: Adapt.px(100),
                      maxHeight: Adapt.px(100),
                      child: _FilterBar(
                        isMovie: state.isMovie,
                        isBusy: state.isbusy,
                        onFilterPress: () =>
                            dispatch(DiscoverPageActionCreator.filterTap()),
                        switchMedia: (isMovie) => dispatch(
                            DiscoverPageActionCreator.mediaTypeChange(isMovie)),
                      )),
                ),
                SliverList(
                  delegate:
                      SliverChildBuilderDelegate((BuildContext ctx, int index) {
                    return _adapter.itemBuilder(ctx, index);
                  }, childCount: _adapter.itemCount),
                ),
                _ShimmerList(isbusy: state.isbusy)
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _ShimmerCell extends StatelessWidget {
  const _ShimmerCell({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _horizontalPadding = Adapt.px(30);
    final _cardHeight = Adapt.px(400);
    final _borderRadius = Adapt.px(40);
    final _imageWidth = Adapt.px(240);
    final _rightPanelPadding = Adapt.px(20);
    final _rightPanelWidth = Adapt.screenW() -
        _imageWidth -
        _horizontalPadding * 2 -
        _rightPanelPadding * 2;
    return Container(
      height: _cardHeight,
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(_borderRadius),
              bottomLeft: Radius.circular(_borderRadius),
              bottomRight: Radius.circular(_imageWidth / 2)),
          child: Container(
            width: _imageWidth,
            height: _cardHeight,
            color: const Color(0xFFAABBCC),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(_rightPanelPadding),
          child: SizedBox(
            width: _rightPanelWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Adapt.px(300),
                  height: Adapt.px(26),
                  color: Color(0xFFFFFFFF),
                ),
                SizedBox(height: Adapt.px(15)),
                Container(
                  width: Adapt.px(80),
                  height: Adapt.px(15),
                  color: Color(0xFFFFFFFF),
                ),
                SizedBox(height: Adapt.px(5)),
                Container(
                  width: Adapt.px(120),
                  height: Adapt.px(15),
                  color: Color(0xFFFFFFFF),
                ),
                SizedBox(height: Adapt.px(10)),
                Container(
                  width: Adapt.px(200),
                  height: Adapt.px(15),
                  color: Color(0xFFFFFFFF),
                ),
                SizedBox(height: Adapt.px(20)),
                Container(
                  height: Adapt.px(20),
                  color: Color(0xFFFFFFFF),
                ),
                SizedBox(height: Adapt.px(10)),
                Container(
                  height: Adapt.px(20),
                  color: Color(0xFFFFFFFF),
                ),
                SizedBox(height: Adapt.px(10)),
                Container(
                  width: Adapt.px(250),
                  height: Adapt.px(20),
                  color: Color(0xFFFFFFFF),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}

class _ShimmerList extends StatelessWidget {
  final bool isbusy;
  const _ShimmerList({this.isbusy});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return SliverToBoxAdapter(
      child:  isbusy?Shimmer.fromColors(
          baseColor: _theme.primaryColorDark,
          highlightColor: _theme.primaryColorLight,
          child: Container(
            margin: EdgeInsets.only(
                top: Adapt.px(10),
                bottom: Adapt.px(30),
                left: Adapt.px(30),
                right: Adapt.px(30)),
            child: Column(
              children: <Widget>[
                const _ShimmerCell(),
                SizedBox(height: Adapt.px(30)),
                const _ShimmerCell(),
                SizedBox(height: Adapt.px(30)),
                const _ShimmerCell(),
              ],
            ),
          ),
      ):SizedBox(),
    );
  }
}

class _FilterBar extends StatelessWidget {
  final Function(bool) switchMedia;
  final bool isMovie;
  final bool isBusy;
  final Function onFilterPress;
  const _FilterBar(
      {this.switchMedia, this.onFilterPress, this.isBusy, this.isMovie});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Container(
      color: _theme.canvasColor,
      child: Stack(children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: Adapt.px(30), vertical: Adapt.px(10)),
          padding: EdgeInsets.symmetric(
              vertical: Adapt.px(5), horizontal: Adapt.px(20)),
          height: Adapt.px(80),
          decoration: BoxDecoration(
            border: Border.all(
                color: _theme.brightness == Brightness.light
                    ? const Color(0xFFEFEFEF)
                    : const Color(0xFF505050)),
            borderRadius: BorderRadius.circular(Adapt.px(20)),
            color: _theme.cardColor,
          ),
          child: Row(
            children: [
              _TapPanel(
                isMovie: isMovie,
                isBusy: isBusy,
                onTap: switchMedia,
              ),
              Expanded(child: SizedBox()),
              GestureDetector(
                onTap: onFilterPress,
                child: Container(
                  padding: EdgeInsets.all(Adapt.px(10)),
                  decoration: BoxDecoration(
                    color: const Color(0xFF334455),
                    borderRadius: BorderRadius.circular(Adapt.px(10)),
                  ),
                  child: Icon(
                    Icons.filter_list,
                    size: Adapt.px(30),
                    color: const Color(0xFFFFFFFF),
                  ),
                ),
              )
            ],
          ),
        ),
        _Loading(isBusy: isBusy),
      ]),
    );
  }
}

class _TapPanel extends StatefulWidget {
  final bool isMovie;
  final bool isBusy;
  final Function(bool) onTap;
  const _TapPanel({this.onTap, this.isMovie, this.isBusy});
  @override
  _TapPanelState createState() => _TapPanelState();
}

class _TapPanelState extends State<_TapPanel> with TickerProviderStateMixin {
  AnimationController _controller;
  bool _isMovie;
  final TextStyle _seletedStyle =
      TextStyle(fontWeight: FontWeight.w500, fontSize: Adapt.px(24));
  final TextStyle _unSelectedStyle =
      TextStyle(color: const Color(0xFF9E9E9E), fontSize: Adapt.px(24));

  Animation<Offset> _position;
  @override
  void didUpdateWidget(_TapPanel oldWidget) {
    if (widget.isMovie != _isMovie && !widget.isBusy) {
      widget.isMovie ? _controller.reverse() : _controller.forward();
      _isMovie = widget.isMovie;
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _isMovie = widget.isMovie ?? true;
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _position = Tween<Offset>(begin: Offset.zero, end: Offset(1, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
    super.initState();
  }

  @override
  void dispose() {
    _controller?.stop();
    _controller?.dispose();
    super.dispose();
  }

  onTap(bool isMovie) {
    if (_isMovie == isMovie && widget.isBusy) return;
    if (widget.onTap != null) widget.onTap(isMovie);
  }

  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Stack(children: [
      Row(children: [
        _TapCell(
          onTap: () => onTap(true),
          title: 'Movie',
          textStyle: _isMovie ? _seletedStyle : _unSelectedStyle,
        ),
        _TapCell(
          onTap: () => onTap(false),
          title: 'TvShow',
          textStyle: _isMovie ? _unSelectedStyle : _seletedStyle,
        ),
      ]),
      SlideTransition(
        position: _position,
        child: Container(
          padding: EdgeInsets.only(top: Adapt.px(50)),
          width: Adapt.px(100),
          child: Container(
            width: Adapt.px(8),
            height: Adapt.px(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _theme.brightness == Brightness.light
                  ? const Color(0xFF334455)
                  : const Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
    ]);
  }
}

class _TapCell extends StatelessWidget {
  final String title;
  final TextStyle textStyle;
  final Function onTap;
  const _TapCell({this.title, this.onTap, this.textStyle});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: Adapt.px(100),
        child: Center(
          child: Text(
            title,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  final bool isBusy;
  const _Loading({this.isBusy});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _brightness = _theme.brightness == Brightness.light;
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: isBusy
          ? Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.symmetric(
                  horizontal: Adapt.px(40), vertical: Adapt.px(10)),
              padding: EdgeInsets.symmetric(
                  vertical: Adapt.px(1), horizontal: Adapt.px(20)),
              height: Adapt.px(80),
              child: SizedBox(
                height: Adapt.px(2),
                child: LinearProgressIndicator(
                  backgroundColor: _brightness
                      ? const Color(0xFFEFEFEF)
                      : const Color(0xFF505050),
                  valueColor: AlwaysStoppedAnimation(
                    _brightness
                        ? const Color(0xFF334455)
                        : const Color(0xFFFFFFFF),
                  ),
                ),
              ),
            )
          : SizedBox(),
    );
  }
}
