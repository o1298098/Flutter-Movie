import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';

import 'state.dart';

Widget buildView(
    AppBarState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);

  return SliverAppBar(
    expandedHeight: Adapt.px(400),
    pinned: true,
    centerTitle: true,
    stretch: true,
    backgroundColor: const Color(0xFFA0BBCC),
    flexibleSpace: Stack(fit: StackFit.expand, children: [
      Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.only(left: Adapt.px(60), bottom: Adapt.px(20)),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                    ImageUrl.getUrl(state.backdropPath, ImageSize.w500)))),
        child: SlideTransition(
            position: Tween<Offset>(begin: Offset.zero, end: Offset(1.6, 0))
                .animate(state.animationController),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Adapt.px(35)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.white.withOpacity(.1),
                  alignment: Alignment.centerLeft,
                  width: Adapt.px(250),
                  height: Adapt.px(70),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: Adapt.px(70),
                        width: Adapt.px(70),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _theme.backgroundColor),
                        child: Icon(Icons.play_arrow),
                      ),
                      SizedBox(width: Adapt.px(20)),
                      const Text(
                        'Play Latest',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    ]),
  );
}
