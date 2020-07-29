import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/video_list.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/widgets/linear_progress_Indicator.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    RecommendationState state, Dispatch dispatch, ViewService viewService) {
  return _RecommendationList(
    onTap: (d) => dispatch(RecommendationActionCreator.cellTap(d)),
    recommendations: state.detail?.recommendations?.results ?? [],
  );
}

class _RecommendationList extends StatelessWidget {
  final List<VideoListResult> recommendations;

  final Function(VideoListResult) onTap;
  const _RecommendationList({this.recommendations, this.onTap});
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((_, index) {
        return _RecommendationCell(
          data: recommendations[index],
          onTap: onTap,
        );
      }, childCount: recommendations.length),
    );
  }
}

class _RecommendationCell extends StatelessWidget {
  final VideoListResult data;
  final Function(VideoListResult) onTap;
  const _RecommendationCell({this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return GestureDetector(
      onTap: () => onTap(data),
      child: Padding(
        padding: EdgeInsets.only(bottom: Adapt.px(30)),
        child: Row(
          children: [
            Container(
              width: Adapt.px(220),
              height: Adapt.px(122),
              decoration: BoxDecoration(
                color: _theme.primaryColorDark,
                borderRadius: BorderRadius.circular(Adapt.px(15)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    ImageUrl.getUrl(data.backdropPath, ImageSize.w300),
                  ),
                ),
              ),
            ),
            SizedBox(width: Adapt.px(20)),
            SizedBox(
              width: Adapt.screenW() - Adapt.px(320),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${data.title}',
                    style: TextStyle(fontSize: Adapt.px(26)),
                  ),
                  const SizedBox(height: 6),
                  Row(children: [
                    LinearGradientProgressIndicator(
                        value: data.voteAverage / 10),
                    const SizedBox(width: 6),
                    Text(
                      data.voteAverage.toStringAsFixed(1),
                      style: TextStyle(
                          fontSize: Adapt.px(20),
                          color: const Color(0xFF717171)),
                    )
                  ])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
