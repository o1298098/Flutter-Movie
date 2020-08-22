import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/genres.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/search_result.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/trending_page/action.dart';
import 'package:parallax_image/parallax_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    TrendingCellState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  final SearchResult d = state.cellData;
  return GestureDetector(
    key: ValueKey('trendingCell${d.id}+${d.name}'),
    onTap: () => dispatch(TrendingPageActionCreator.cellTapped(d)),
    child: Container(
      margin: EdgeInsets.only(
          bottom: Adapt.px(50), left: Adapt.px(30), right: Adapt.px(30)),
      decoration: BoxDecoration(
        color: _theme.cardColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              blurRadius: Adapt.px(15),
              offset: Offset(Adapt.px(10), Adapt.px(15)),
              color: _theme.primaryColorDark)
        ],
        borderRadius: BorderRadius.circular(Adapt.px(30)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _ImageCell(url: d.posterPath ?? d.profilePath),
          SizedBox(width: Adapt.px(50)),
          _Info(
            data: d,
            index: state.index,
          ),
          Container(
            height: Adapt.px(280),
            child: IconButton(
              padding: EdgeInsets.only(left: Adapt.px(20)),
              iconSize: Adapt.px(40),
              icon: state.liked
                  ? const Icon(
                      Icons.favorite,
                      color: const Color(0xFFFF0000),
                    )
                  : const Icon(Icons.favorite_border),
              onPressed: () => dispatch(TrendingCellActionCreator.onLikeTap()),
            ),
          )
        ],
      ),
    ),
  );
}

class _ImageCell extends StatelessWidget {
  final String url;
  const _ImageCell({this.url});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Container(
      width: Adapt.px(280),
      height: Adapt.px(280),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Adapt.px(30)),
        child: Container(
          color: _theme.primaryColorDark,
          child: ParallaxImage(
            extent: Adapt.px(280),
            image: CachedNetworkImageProvider(
              ImageUrl.getUrl(url, ImageSize.w300),
            ),
          ),
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  final int index;
  final SearchResult data;
  const _Info({this.data, this.index});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: Adapt.px(20),
        ),
        Text(
          '${index + 1}',
          style: TextStyle(fontSize: Adapt.px(50), fontWeight: FontWeight.w800),
        ),
        SizedBox(
          width: Adapt.screenW() - Adapt.px(490),
          child: Text(
            data.title ?? data.name,
            style:
                TextStyle(fontSize: Adapt.px(28), fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(height: Adapt.px(10)),
        SizedBox(
            width: Adapt.screenW() - Adapt.px(490),
            child: Text(
              (data.genreIds ?? [])
                  .take(3)
                  .map((f) {
                    return data.mediaType == 'movie'
                        ? Genres.instance.movieList[f]?.replaceAll('_', ' & ')
                        : Genres.instance.tvList[f]?.replaceAll('_', ' & ');
                  })
                  .toList()
                  .join(' / '),
              style: TextStyle(
                  color: const Color(0xFF9E9E9E), fontSize: Adapt.px(22)),
            ))
      ],
    );
  }
}
