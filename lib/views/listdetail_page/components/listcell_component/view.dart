import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/listdetail_page/action.dart';

import 'state.dart';

Widget buildView(
    ListCellState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  final d = state.cellData;
  return GestureDetector(
    onTap: () => dispatch(ListDetailPageActionCreator.cellTapped(d)),
    child: Container(
      decoration: BoxDecoration(
          color: _theme.primaryColorDark,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(
                  ImageUrl.getUrl(d.photoUrl, ImageSize.w300)))),
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(Adapt.px(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.star,
                    color: Colors.white,
                    size: Adapt.px(30),
                  ),
                  Text(
                    d.rated.toStringAsFixed(1),
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ))
        ],
      ),
    ),
  );
}
