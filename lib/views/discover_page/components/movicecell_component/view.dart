import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/genres.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/video_list.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/discover_page/action.dart';
import 'package:movie/widgets/linear_progress_Indicator.dart';

import 'state.dart';

Widget buildView(
    VideoCellState state, Dispatch dispatch, ViewService viewService) {
  final VideoListResult d = state.videodata;
  if (d == null) return SizedBox();
  return _Card(
    data: d,
    onTap: (value) => dispatch(DiscoverPageActionCreator.onVideoCellTapped(
        value.id,
        value.posterPath,
        value.posterPath,
        value.title ?? value.name)),
  );
}

String _changeDatetime(String s1) {
  return s1 == null || s1 == '' || s1.length < 10 ? '1900-01-01' : s1;
}

class _Card extends StatelessWidget {
  final VideoListResult data;

  final Function(VideoListResult) onTap;
  const _Card({this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    final bool _isMovie = data.title != null;
    final _horizontalPadding = Adapt.px(30);
    final _cardHeight = Adapt.px(400);
    final _borderRadius = Adapt.px(40);
    final _imageWidth = Adapt.px(240);
    final _rightPanelPadding = Adapt.px(20);
    final _rightPanelWidth = Adapt.screenW() -
        _imageWidth -
        _horizontalPadding * 2 -
        _rightPanelPadding * 2;
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Container(
      key: ValueKey('${data.name}${data.id}'),
      margin: EdgeInsets.symmetric(
          horizontal: _horizontalPadding, vertical: Adapt.px(20)),
      height: _cardHeight,
      decoration: BoxDecoration(
          color: _theme.cardColor,
          borderRadius: BorderRadius.circular(_borderRadius),
          boxShadow: [
            BoxShadow(
                offset: Offset(5, 5),
                color: _theme.brightness == Brightness.light
                    ? _theme.primaryColorDark
                    : const Color(0xFF303030),
                blurRadius: 5)
          ]),
      child: GestureDetector(
        onTap: () => onTap(data),
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
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: ImageUrl.getUrl(data.posterPath, ImageSize.w300),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(_rightPanelPadding),
            child: SizedBox(
              width: _rightPanelWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title ?? data.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: Adapt.px(30),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: Adapt.px(5)),
                  Text(
                    DateFormat.yMMMd().format(
                      DateTime?.tryParse(
                        (_isMovie
                            ? _changeDatetime(data.releaseDate)
                            : _changeDatetime(data.firstAirDate)),
                      ),
                    ),
                    style: TextStyle(
                        color: const Color(0xFF9E9E9E), fontSize: Adapt.px(18)),
                  ),
                  SizedBox(height: Adapt.px(5)),
                  Text(
                    data.genreIds
                        .take(3)
                        .map((e) => _isMovie
                            ? Genres.instance.movieList[e]
                            : Genres.instance.tvList[e])
                        .join(' / '),
                    style: TextStyle(
                        fontSize: Adapt.px(18), color: const Color(0xFF9E9E9E)),
                  ),
                  SizedBox(height: Adapt.px(10)),
                  Row(children: [
                    LinearGradientProgressIndicator(
                      value: data.voteAverage / 10,
                      width: Adapt.px(150),
                    ),
                    SizedBox(width: Adapt.px(10)),
                    Text(
                      data.voteAverage.toString(),
                      style: TextStyle(
                          fontSize: Adapt.px(20),
                          color: const Color(0xFF9E9E9E)),
                    )
                  ]),
                  SizedBox(height: Adapt.px(20)),
                  Text(
                    data.overview,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
                        color: const Color(0xFF717171)),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: Adapt.px(80),
                      height: Adapt.px(60),
                      decoration: BoxDecoration(
                        color: const Color(0xFF334455),
                        borderRadius: BorderRadius.circular(Adapt.px(20)),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.chevron_right,
                          color: const Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
