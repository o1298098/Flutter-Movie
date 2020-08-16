import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
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
    RecommendationState state, Dispatch dispatch, ViewService viewService) {
  return AnimatedSwitcher(
    duration: Duration(milliseconds: 300),
    child: state.data == null
        ? const _ShimmerList()
        : state.data.length > 0
            ? _RecommendationPanel(
                data: state.data,
                onTap: (d) =>
                    dispatch(RecommendationActionCreator.cellTapped(d)),
              )
            : SizedBox(),
  );
}

class _RecommendationCell extends StatelessWidget {
  final VideoListResult data;
  final Function(VideoListResult) onTap;
  const _RecommendationCell({this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _width = Adapt.px(130);
    return GestureDetector(
      onTap: () => onTap(data),
      child: Column(
        children: [
          Container(
            width: _width,
            height: Adapt.px(200),
            decoration: BoxDecoration(
              color: _theme.primaryColorDark,
              borderRadius: BorderRadius.circular(Adapt.px(20)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  ImageUrl.getUrl(data.posterPath, ImageSize.w300),
                ),
              ),
            ),
          ),
          SizedBox(height: Adapt.px(20)),
          SizedBox(
            width: _width,
            child: Text(
              data.name,
              maxLines: 3,
              overflow: TextOverflow.fade,
              style: TextStyle(fontSize: Adapt.px(20)),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecommendationPanel extends StatelessWidget {
  final List<VideoListResult> data;
  final Function(VideoListResult) onTap;
  const _RecommendationPanel({this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    final _padding = Adapt.px(40);
    final _listViewHeight = Adapt.px(320);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _padding),
          child: Text(
            I18n.of(context).recommendations,
            style: TextStyle(
              fontSize: Adapt.px(28),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: Adapt.px(30)),
        SizedBox(
          height: _listViewHeight,
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: _padding),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => SizedBox(width: Adapt.px(40)),
            itemCount: data.length,
            itemBuilder: (_, index) => _RecommendationCell(
              data: data[index],
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}

class _ShimmerCell extends StatelessWidget {
  const _ShimmerCell();
  @override
  Widget build(BuildContext context) {
    final _width = Adapt.px(130);
    final _color = const Color(0xFFFFFFFF);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: _width,
        height: Adapt.px(200),
        decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.circular(Adapt.px(20)),
        ),
      ),
      SizedBox(height: Adapt.px(20)),
      Container(
        color: _color,
        width: _width,
        height: Adapt.px(18),
      ),
      SizedBox(height: Adapt.px(8)),
      Container(
        color: _color,
        height: Adapt.px(18),
        width: Adapt.px(100),
      ),
    ]);
  }
}

class _ShimmerList extends StatelessWidget {
  const _ShimmerList();
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _padding = Adapt.px(40);
    final _listViewHeight = Adapt.px(320);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _padding),
          child: Text(
            I18n.of(context).recommendations,
            style: TextStyle(
              fontSize: Adapt.px(28),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: Adapt.px(30)),
        SizedBox(
          height: _listViewHeight,
          child: Shimmer.fromColors(
            baseColor: _theme.primaryColorDark,
            highlightColor: _theme.primaryColorLight,
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: _padding),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) => SizedBox(width: Adapt.px(40)),
              itemCount: 5,
              itemBuilder: (_, index) => const _ShimmerCell(),
            ),
          ),
        ),
      ],
    );
  }
}
