import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/actions/timeline_convert.dart';
import 'package:movie/models/base_api_model/cast_list_detail.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    CastListDetailState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
      //appBar: AppBar(title: Text(state.castList?.name ?? '')),
      body: Stack(children: [
    CustomScrollView(
      controller: state.scrollController,
      slivers: [
        _Header(
          title: state.castList?.name,
          description: state.castList?.description,
          background: state.castList?.backgroundUrl == null ||
                  state.castList?.backgroundUrl?.isEmpty == true
              ? 'https://img.freepik.com/free-vector/people-waving-hand-illustration-concept_52683-29825.jpg?size=626&ext=jpg'
              : state.castList.backgroundUrl,
          count: state.castList?.castCount ?? 0,
          updateTime: TimeLineConvert.instance.getTimeLine(
              state.castList?.updateTime ?? DateTime.parse('2020-01-01')),
        ),
        const _CastListTitle(),
        _CastList(
          data: state.listDetail?.data,
          onCastTap: (d) => dispatch(CastListDetailActionCreator.onCastTap(d)),
          onDeleteTap: (d) =>
              dispatch(CastListDetailActionCreator.onDeleteTap(d)),
        ),
        _LoadingPanel(loading: state.loading),
      ],
    ),
    _AppBar(
      scrollController: state.scrollController,
      totalHeight: MediaQuery.of(viewService.context).size.width,
      opacityHeight: 120,
      title: state.castList.name,
    )
  ]));
}

class _Header extends StatelessWidget {
  final String background;
  final String title;
  final String description;
  final String updateTime;
  final int count;
  const _Header(
      {this.title,
      this.background,
      this.description,
      this.updateTime,
      this.count});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final Size _size = MediaQuery.of(context).size;
    final double _headerSize = _size.width - 10;
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          child: Container(
              width: _headerSize,
              height: _headerSize,
              decoration: BoxDecoration(
                color: _theme.primaryColorLight,
                image: background != null
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(background),
                      )
                    : null,
              ),
              child: _ListInfo(
                title: title,
                background: background,
                description: description,
                updateTime: updateTime,
                count: count,
              )),
        ),
      ),
    );
  }
}

class _ListInfo extends StatelessWidget {
  final String background;
  final String title;
  final String description;
  final String updateTime;
  final int count;
  const _ListInfo(
      {this.title,
      this.background,
      this.description,
      this.updateTime,
      this.count});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  const Color(0xC0000000),
                  const Color(0x00000000),
                ],
              ),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFFFFFFF)),
              ),
              SizedBox(height: 5),
              Text(
                description ?? '',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: const Color(0xFFFFFFFF),
                ),
              ),
              SizedBox(height: 5),
              Text(
                '$count casts · updated $updateTime',
                style: TextStyle(fontSize: 12, color: const Color(0xFFF0F0F0)),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class _AppBar extends StatefulWidget {
  final ScrollController scrollController;
  final double opacityHeight;
  final double totalHeight;
  final String title;
  const _AppBar(
      {this.scrollController,
      this.opacityHeight,
      this.totalHeight,
      this.title});
  @override
  _AppBarState createState() => _AppBarState();
}

class _AppBarState extends State<_AppBar> {
  bool _showBar = false;
  double _opacity = 0.0;
  double _appBarChangeHeight;

  @override
  void initState() {
    widget.scrollController?.addListener(_changeBackground);
    _setheight();
    super.initState();
  }

  @override
  void didUpdateWidget(_AppBar oldWidget) {
    if (oldWidget.opacityHeight != widget.opacityHeight ||
        oldWidget.totalHeight != widget.totalHeight) _setheight();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_changeBackground);
    super.dispose();
  }

  void _setheight() {
    _appBarChangeHeight = widget.totalHeight - widget.opacityHeight;
  }

  void _changeBackground() {
    if (widget.scrollController.position.pixels >= _appBarChangeHeight) {
      double v = widget.opacityHeight -
          (widget.totalHeight - widget.scrollController.position.pixels);
      v = v > widget.opacityHeight || v < 0 ? widget.opacityHeight : v;
      _opacity = v / widget.opacityHeight;
      _showBar = true;
    } else {
      _showBar = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: _showBar
          ? AppBar(
              key: ValueKey('AppBarShow'),
              backgroundColor: _theme.backgroundColor.withOpacity(_opacity),
              brightness: _theme.brightness,
              iconTheme: _theme.iconTheme,
              title: Text(
                widget.title ?? '',
                style: TextStyle(color: _theme.textTheme.bodyText1.color),
              ),
            )
          : AppBar(
              key: ValueKey('AppBarHide'),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: InkWell(
                child: Container(
                  margin: EdgeInsets.all(12),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: const Color(0x60000000)),
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    color: const Color(0xFFFFFFFF),
                  ),
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
    );
  }
}

class _CastListTitle extends StatelessWidget {
  const _CastListTitle();
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Text(
        'Casts',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
    ));
  }
}

class _CastList extends StatelessWidget {
  final List<BaseCast> data;
  final Function(BaseCast) onCastTap;
  final Function(BaseCast) onDeleteTap;
  const _CastList({this.data, this.onCastTap, this.onDeleteTap});
  @override
  Widget build(BuildContext context) {
    return data == null
        ? const _ShimmerList()
        : data.length > 0
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, index) {
                    return _CastCell(
                      data: data[index],
                      onCastTap: onCastTap,
                      onDeleteTap: onDeleteTap,
                    );
                  },
                  childCount: data.length,
                ),
              )
            : SliverToBoxAdapter(
                child: SizedBox(
                  height: 200,
                  child: Center(
                      child: Text(
                    'Empty List',
                    style: TextStyle(
                      color: const Color(0xFF717171),
                    ),
                  )),
                ),
              );
  }
}

class _CastCell extends StatelessWidget {
  final BaseCast data;
  final Function(BaseCast) onCastTap;
  final Function(BaseCast) onDeleteTap;
  const _CastCell({this.data, this.onCastTap, this.onDeleteTap});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Row(children: [
        GestureDetector(
          onTap: () => onCastTap(data),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _theme.primaryColorDark,
              boxShadow: _theme.brightness == Brightness.light
                  ? [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 5.0,
                        spreadRadius: -5.0,
                        color: const Color(0xFF9E9E9E),
                      )
                    ]
                  : null,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  ImageUrl.getUrl(data.profileUrl, ImageSize.w300),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () => onCastTap(data),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data?.name ?? '',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'updated ${TimeLineConvert.instance.getTimeLine(data?.updateTime ?? DateTime.parse('2020-01-01'))}',
                style: TextStyle(color: const Color(0xFF717171)),
              )
            ],
          ),
        ),
        Spacer(),
        InkWell(
          onTap: () => onDeleteTap(data),
          child: Icon(Icons.remove_circle_outline),
        )
      ]),
    );
  }
}

class _ShimmerCell extends StatelessWidget {
  const _ShimmerCell();
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Row(children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _theme.primaryColorDark,
          ),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: _theme.primaryColorDark,
              width: 200,
              height: 20,
            ),
            SizedBox(height: 5),
            Container(
              color: _theme.primaryColorDark,
              width: 100,
              height: 10,
            ),
          ],
        ),
      ]),
    );
  }
}

class _ShimmerList extends StatelessWidget {
  const _ShimmerList();
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, __) {
          return _ShimmerCell();
        },
        childCount: 4,
      ),
    );
  }
}

class _LoadingPanel extends StatelessWidget {
  final bool loading;
  const _LoadingPanel({this.loading = false});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return SliverToBoxAdapter(
      child: loading
          ? SizedBox(
              height: 60,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(_theme.iconTheme.color),
                ),
              ),
            )
          : SizedBox(),
    );
  }
}
