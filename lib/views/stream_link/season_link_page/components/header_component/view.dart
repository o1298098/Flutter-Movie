import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';

import 'state.dart';

Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
  return SliverToBoxAdapter(
    key: ValueKey('header'),
    child: Container(
      padding: EdgeInsets.symmetric(
          horizontal: Adapt.px(30), vertical: Adapt.px(50)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(state.genres.map((f) => f.name).join(' , ')),
          SizedBox(height: Adapt.px(5)),
          Text(
            state.name,
            style:
                TextStyle(fontWeight: FontWeight.w700, fontSize: Adapt.px(55)),
          ),
          SizedBox(height: Adapt.px(30)),
          _HeaderInfo(
            overview: state.overview,
            posterPath: state.posterPath,
          ),
        ],
      ),
    ),
  );
}

class _HeaderInfo extends StatelessWidget {
  final String overview;
  final String posterPath;
  const _HeaderInfo({this.overview, this.posterPath});
  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Container(
      height: Adapt.px(160),
      decoration: BoxDecoration(
        color: _mediaQuery.platformBrightness == Brightness.light
            ? Color(0xFFF6F5FA)
            : _theme.primaryColorDark,
        borderRadius: BorderRadius.circular(Adapt.px(15)),
      ),
      padding: EdgeInsets.all(Adapt.px(25)),
      child: Row(
        children: <Widget>[
          Container(
            width: Adapt.px(110),
            height: Adapt.px(110),
            decoration: BoxDecoration(
              color: _theme.primaryColorDark,
              borderRadius: BorderRadius.circular(Adapt.px(15)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  ImageUrl.getUrl(posterPath, ImageSize.w200),
                ),
              ),
            ),
          ),
          SizedBox(width: Adapt.px(25)),
          SizedBox(
            width: Adapt.screenW() - Adapt.px(265),
            child: Text(
              overview,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: Adapt.px(28)),
            ),
          )
        ],
      ),
    );
  }
}
