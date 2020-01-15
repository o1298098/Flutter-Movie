import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/videolist.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/detail_page/action.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    RecommendationsState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);

  Widget _buildRecommendationShimmerCell() {
    double _width = Adapt.px(220);
    return SizedBox(
      width: _width,
      child: Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: _width,
              height: Adapt.px(320),
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
            ),
            SizedBox(
              height: Adapt.px(15),
            ),
            Container(
              width: _width,
              height: Adapt.px(30),
              color: Colors.grey[200],
            ),
            SizedBox(
              height: Adapt.px(8),
            ),
            Container(
              width: _width - Adapt.px(50),
              height: Adapt.px(30),
              color: Colors.grey[200],
            ),
            SizedBox(
              height: Adapt.px(8),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String url, double width, double height, double radius,
      {EdgeInsetsGeometry margin = EdgeInsets.zero, ValueKey key}) {
    return Container(
      key: key,
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
          color: _theme.primaryColorDark,
          borderRadius: BorderRadius.circular(radius),
          image: DecorationImage(
              fit: BoxFit.cover, image: CachedNetworkImageProvider(url))),
    );
  }

  Widget _buildRecommendationCell(VideoListResult d) {
    double _width = Adapt.px(220);
    return GestureDetector(
      key: ValueKey('recommendation${d.id}'),
      onTap: () => dispatch(
          MovieDetailPageActionCreator.movieCellTapped(d.id, d.posterPath)),
      child: Padding(
        padding: EdgeInsets.only(right: Adapt.px(30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildImage(ImageUrl.getUrl(d.posterPath, ImageSize.w500), _width,
                Adapt.px(320), Adapt.px(20)),
            SizedBox(
              height: Adapt.px(15),
            ),
            Container(
              width: _width,
              child: Text(
                d.title,
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
                '${DateTime.parse(d.releaseDate == null || d.releaseDate == '' ? '2020-01-01' : d.releaseDate).year}',
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
                  rating: d.voteAverage / 2,
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendations() {
    var _model = state.recommendations;
    return SliverToBoxAdapter(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
            child: Text(
              I18n.of(viewService.context).recommendations,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: Adapt.px(35)),
            ),
          ),
          SizedBox(
            height: Adapt.px(30),
          ),
          Container(
            height: Adapt.px(450),
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: _model.length == 0
                    ? <Widget>[
                        SizedBox(
                          width: Adapt.px(40),
                        ),
                        _buildRecommendationShimmerCell(),
                        SizedBox(
                          width: Adapt.px(30),
                        ),
                        _buildRecommendationShimmerCell(),
                        SizedBox(
                          width: Adapt.px(30),
                        ),
                        _buildRecommendationShimmerCell()
                      ]
                    : (state.recommendations
                            ?.map(_buildRecommendationCell)
                            ?.toList() ??
                        []
                      ..insert(
                          0,
                          SizedBox(
                            width: Adapt.px(40),
                          )))),
          ),
          SizedBox(
            height: Adapt.px(30),
          ),
        ]));
  }

  return _buildRecommendations();
}
