import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/video_list.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PopularPosterState state, Dispatch dispatch, ViewService viewService) {
  return Column(
    children: <Widget>[
      _FrontTitel(
        showMovie: state.showmovie,
        dispatch: dispatch,
      ),
      SizedBox(height: Adapt.px(30)),
      _PopBody(
        dispatch: dispatch,
        model: state.showmovie ? state.popularMoives : state.popularTVShows,
      ),
    ],
  );
}

class _ShimmerCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Adapt.px(250),
      height: Adapt.px(350),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: Adapt.px(250),
            height: Adapt.px(350),
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(Adapt.px(15)),
            ),
          ),
          SizedBox(
            height: Adapt.px(20),
          ),
          Container(
            width: Adapt.px(220),
            height: Adapt.px(30),
            color: const Color(0xFFEEEEEE),
          )
        ],
      ),
    );
  }
}

class _ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
          separatorBuilder: (_, __) => SizedBox(width: Adapt.px(30)),
          itemCount: 4,
          itemBuilder: (_, __) => _ShimmerCell(),
        ));
  }
}

class _Cell extends StatelessWidget {
  final VideoListResult data;
  final Function onTap;
  const _Cell({@required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return GestureDetector(
      key: ValueKey(data.id),
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Container(
            width: Adapt.px(250),
            height: Adapt.px(350),
            decoration: BoxDecoration(
              color: _theme.primaryColorDark,
              borderRadius: BorderRadius.circular(Adapt.px(15)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  ImageUrl.getUrl(data.posterPath, ImageSize.w400),
                ),
              ),
            ),
          ),
          Container(
            //alignment: Alignment.bottomCenter,
            width: Adapt.px(250),
            padding: EdgeInsets.all(Adapt.px(10)),
            child: Text(
              data.title ?? data.name,
              maxLines: 2,
              //textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Adapt.px(28),
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _MoreCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: _theme.primaryColorLight,
            borderRadius: BorderRadius.circular(Adapt.px(15)),
          ),
          width: Adapt.px(250),
          height: Adapt.px(350),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  I18n.of(context).more,
                  style: TextStyle(fontSize: Adapt.px(35)),
                ),
                Icon(Icons.arrow_forward, size: Adapt.px(35))
              ]),
        )
      ],
    );
  }
}

class _FrontTitel extends StatelessWidget {
  final bool showMovie;
  final Dispatch dispatch;
  const _FrontTitel({this.showMovie, this.dispatch});
  @override
  Widget build(BuildContext context) {
    final TextStyle _selectPopStyle = TextStyle(
      fontSize: Adapt.px(24),
      fontWeight: FontWeight.bold,
    );

    final TextStyle _unselectPopStyle =
        TextStyle(fontSize: Adapt.px(24), color: const Color(0xFF9E9E9E));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            I18n.of(context).popular,
            style:
                TextStyle(fontSize: Adapt.px(35), fontWeight: FontWeight.bold),
          ),
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: () => dispatch(
                    PopularPosterActionCreator.onPopularFilterChanged(true)),
                child: Text(I18n.of(context).movies,
                    style: showMovie ? _selectPopStyle : _unselectPopStyle),
              ),
              SizedBox(
                width: Adapt.px(20),
              ),
              GestureDetector(
                onTap: () => dispatch(
                    PopularPosterActionCreator.onPopularFilterChanged(false)),
                child: Text(I18n.of(context).tvShows,
                    style: showMovie ? _unselectPopStyle : _selectPopStyle),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _PopBody extends StatelessWidget {
  final VideoListModel model;
  final Dispatch dispatch;
  const _PopBody({this.model, this.dispatch}) : assert(model != null);
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        transitionBuilder: (widget, animated) {
          return SlideTransition(
            position:
                animated.drive(Tween(begin: Offset(1, 0), end: Offset.zero)),
            child: widget,
          );
        },
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        duration: Duration(milliseconds: 300),
        child: Container(
          key: ValueKey(model),
          height: Adapt.px(450),
          child: model.results.length > 0
              ? ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (_, index) => SizedBox(width: Adapt.px(30)),
                  itemCount: model.results.length + 1,
                  itemBuilder: (_, index) {
                    if (index == model.results.length) return _MoreCell();
                    final d = model.results[index];
                    return _Cell(
                      data: d,
                      onTap: () => dispatch(
                          PopularPosterActionCreator.onCellTapped(d.id,
                              d.backdropPath, d.title ?? d.name, d.posterPath)),
                    );
                  },
                )
              : _ShimmerList(),
        ));
  }
}
