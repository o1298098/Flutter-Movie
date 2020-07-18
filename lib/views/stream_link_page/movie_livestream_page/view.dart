import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/creditsmodel.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/moviedetail.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/widgets/expandable_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MovieLiveStreamState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final _theme = ThemeStyle.getTheme(context);

      return Scaffold(
        backgroundColor: _theme.backgroundColor,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: _theme.brightness == Brightness.light
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light,
          child: Stack(
            children: [
              Container(
                child: ListView(
                  controller: state.scrollController,
                  padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
                  children: [
                    SizedBox(
                      height: Adapt.px(30) + Adapt.padTopH(),
                    ),
                    viewService.buildComponent('player'),
                    viewService.buildComponent('header'),
                    viewService.buildComponent('recommendation'),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
              Container(
                color: _theme.backgroundColor,
                height: Adapt.padTopH(),
              ),
              viewService.buildComponent('bottomPanel'),
            ],
          ),
        ),
      );
    },
  );
}

class _Header extends StatelessWidget {
  final MovieDetailModel data;
  const _Header({this.data});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Adapt.px(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data?.title ?? '',
            style: TextStyle(
              fontSize: Adapt.px(35),
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
          ),
          SizedBox(height: Adapt.px(40)),
          Row(children: [
            Container(
              width: Adapt.px(80),
              height: Adapt.px(80),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Adapt.px(20)),
                image: data.posterPath != null
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          ImageUrl.getUrl(data.posterPath, ImageSize.w300),
                        ),
                      )
                    : null,
              ),
            ),
            SizedBox(width: Adapt.px(10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMd().format(DateTime.parse(data.releaseDate)),
                ),
                Text(
                  data.genres.take(2).map((e) => e.name).join(' · '),
                  style: TextStyle(
                    fontSize: Adapt.px(24),
                    color: const Color(0xFF717171),
                  ),
                ),
              ],
            ),
            Spacer(),
            _CastCell(casts: data?.credits?.cast ?? [])
          ]),
          SizedBox(height: Adapt.px(40)),
          ExpandableText(
            data.overview,
            maxLines: 3,
            style: TextStyle(color: const Color(0xFF717171), height: 1.5),
          )
        ],
      ),
    );
  }
}

class _CastCell extends StatelessWidget {
  final List<CastData> casts;
  const _CastCell({this.casts});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Container(
      width: Adapt.px(240),
      child: Row(
        children: casts
            .take(4)
            .map((e) {
              final int _index = casts.indexOf(e);
              return Container(
                width: Adapt.px(60),
                height: Adapt.px(60),
                transform: Matrix4.translationValues(10.0 * _index, 0, 0),
                decoration: BoxDecoration(
                  color: _theme.primaryColorDark,
                  border: Border.all(
                    color: const Color(0xFFFFFFFF),
                    width: 1,
                  ),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                        ImageUrl.getUrl(e.profilePath, ImageSize.w300)),
                  ),
                ),
              );
            })
            .toList()
            .reversed
            .toList(),
      ),
    );
  }
}
