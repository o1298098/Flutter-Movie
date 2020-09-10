import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';

import 'state.dart';

Widget buildView(CastState state, Dispatch dispatch, ViewService viewService) {
  final _theme = ThemeStyle.getTheme(viewService.context);
  return Container(
    width: Adapt.px(240),
    child: Row(
      children: state.casts
          .take(4)
          .map((e) {
            final int _index = state.casts.indexOf(e);
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
