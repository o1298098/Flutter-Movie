import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/video_list.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/detail_page/action.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(
    RecommendationsState state, Dispatch dispatch, ViewService viewService) {
  final _model = state.recommendations;
  return SliverToBoxAdapter(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
          child: Text(
            I18n.of(viewService.context).recommendations,
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: Adapt.px(28)),
          ),
        ),
        SizedBox(height: Adapt.px(30)),
        Container(
          height: Adapt.px(450),
          child: _model.length == 0
              ? _ShimmmerList()
              : _RecommendationList(
                  data: _model,
                  dispatch: dispatch,
                ),
        ),
        SizedBox(height: Adapt.px(30)),
      ]));
}

class _ShimmerCell extends StatelessWidget {
  final double _width = Adapt.px(220);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: _width,
            height: Adapt.px(320),
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
            ),
          ),
          SizedBox(height: Adapt.px(15)),
          Container(
            width: _width,
            height: Adapt.px(30),
            color: const Color(0xFFEEEEEE),
          ),
          SizedBox(height: Adapt.px(8)),
          Container(
            width: _width - Adapt.px(50),
            height: Adapt.px(30),
            color: const Color(0xFFEEEEEE),
          ),
          SizedBox(height: Adapt.px(8)),
        ],
      ),
    );
  }
}

class _ShimmmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
          separatorBuilder: (_, __) => SizedBox(width: Adapt.px(30)),
          itemCount: 4,
          itemBuilder: (_, __) => _ShimmerCell(),
        ));
  }
}

class _RecommendationCell extends StatelessWidget {
  final VideoListResult data;
  final Function onTap;
  const _RecommendationCell({@required this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    final double _width = Adapt.px(220);
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return GestureDetector(
      key: ValueKey('recommendation${data.id}'),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: _width,
            height: Adapt.px(320),
            decoration: BoxDecoration(
                color: _theme.primaryColorDark,
                borderRadius: BorderRadius.circular(Adapt.px(20)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                        ImageUrl.getUrl(data.posterPath, ImageSize.w500)))),
          ),
          SizedBox(
            height: Adapt.px(15),
          ),
          Container(
            width: _width,
            child: Text(
              data.title,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: Adapt.px(24)),
            ),
          ),
          SizedBox(
            height: Adapt.px(8),
          ),
          Text(
              '${DateTime.parse(data.releaseDate == null || data.releaseDate == '' ? '2020-01-01' : data.releaseDate).year}',
              style: TextStyle(fontSize: Adapt.px(24))),
          SizedBox(
            height: Adapt.px(8),
          ),
          Container(
              width: _width,
              child: RatingBarIndicator(
                itemPadding: EdgeInsets.only(right: Adapt.px(5)),
                itemSize: Adapt.px(25),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                unratedColor: Colors.grey[300],
                rating: data.voteAverage / 2,
              ))
        ],
      ),
    );
  }
}

class _RecommendationList extends StatelessWidget {
  final List<VideoListResult> data;
  final Dispatch dispatch;
  const _RecommendationList({this.data, this.dispatch});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
      separatorBuilder: (_, __) => SizedBox(width: Adapt.px(30)),
      itemCount: data.length,
      itemBuilder: (_, index) {
        final d = data[index];
        return _RecommendationCell(
          data: d,
          onTap: () => dispatch(
              MovieDetailPageActionCreator.movieCellTapped(d.id, d.posterPath)),
        );
      },
    );
  }
}
