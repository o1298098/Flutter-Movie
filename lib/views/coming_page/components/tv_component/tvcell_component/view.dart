import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    TVCellState state, Dispatch dispatch, ViewService viewService) {
  final MediaQueryData _mediaQuery = MediaQuery.of(viewService.context);
  final ThemeData _theme = _mediaQuery.platformBrightness == Brightness.light
      ? ThemeStyle.lightTheme
      : ThemeStyle.darkTheme;
  final d = state.tvResult;
  return InkWell(
    onTap: () => dispatch(TVCellActionCreator.cellTapped(d)),
    child: Container(
      padding: EdgeInsets.all(Adapt.px(20)),
      child: Row(
        children: <Widget>[
          Container(
            width: Adapt.px(120),
            height: Adapt.px(180),
            decoration: BoxDecoration(
              color: _theme.primaryColorLight,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  ImageUrl.getUrl(d.posterPath, ImageSize.w300),
                ),
              ),
            ),
          ),
          SizedBox(
            width: Adapt.px(20),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: Adapt.screenW() - Adapt.px(180),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: d?.name ?? '-',
                        style: TextStyle(
                            fontSize: Adapt.px(30),
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' (${d.nextEpisodeNumber ?? '-'})',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: Adapt.px(30),
                        ),
                      ),
                    ],
                  ),
                  maxLines: 1,
                ),
              ),
              Text('Season:' + (d.season ?? '-')),
              Text(
                "Air Date: " + (d.nextAirDate == null ? '-' : d.nextAirDate),
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: Adapt.px(24),
                ),
              ),
              SizedBox(
                height: Adapt.px(8),
              ),
              Container(
                width: Adapt.screenW() - Adapt.px(200),
                child: Text(
                  d.overview ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}
