import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/customwidgets/shimmercell.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/detail_page/action.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(StillState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  Widget _buildImage(String url, double width, double height, double radius,
      {EdgeInsetsGeometry margin = EdgeInsets.zero, ValueKey key}) {
    return Container(
      key: key,
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
          color: _theme.primaryColorDark,
          borderRadius: BorderRadius.circular(radius),
          image: DecorationImage(
              fit: BoxFit.cover, image: CachedNetworkImageProvider(url))),
    );
  }

  Widget _buildImageCell(ImageData d) {
    String url = ImageUrl.getUrl(d.filePath, ImageSize.w500);
    int index = state.imagesmodel.backdrops.indexOf(d);
    return GestureDetector(
      key: ValueKey('image${d.filePath}'),
      onTap: () =>
          dispatch(MovieDetailPageActionCreator.stillImageTapped(index)),
      child: Hero(
          tag: url + index.toString(),
          child: _buildImage(
            url,
            Adapt.px(320),
            Adapt.px(180),
            Adapt.px(15),
            margin: EdgeInsets.only(right: Adapt.px(30)),
          )),
    );
  }

  Widget _buildStill() {
    return SliverToBoxAdapter(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: Adapt.px(30),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
              child: Text(
                'Stills',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: Adapt.px(35)),
              ),
            ),
            SizedBox(
              height: Adapt.px(30),
            ),
            Container(
              height: Adapt.px(180),
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: state.imagesmodel.backdrops.length == 0
                      ? <Widget>[
                          SizedBox(
                            width: Adapt.px(40),
                          ),
                          ShimmerCell(
                              Adapt.px(320), Adapt.px(180), Adapt.px(20),
                              baseColor: _theme.primaryColorDark,
                              highlightColor: _theme.primaryColorLight),
                          SizedBox(
                            width: Adapt.px(30),
                          ),
                          ShimmerCell(
                              Adapt.px(320), Adapt.px(180), Adapt.px(20),
                              baseColor: _theme.primaryColorDark,
                              highlightColor: _theme.primaryColorLight),
                          SizedBox(
                            width: Adapt.px(30),
                          ),
                          ShimmerCell(
                              Adapt.px(320), Adapt.px(180), Adapt.px(20),
                              baseColor: _theme.primaryColorDark,
                              highlightColor: _theme.primaryColorLight)
                        ]
                      : (state.imagesmodel.backdrops
                          .map(_buildImageCell)
                          .toList()
                            ..insert(
                                0,
                                SizedBox(
                                  width: Adapt.px(40),
                                )))),
            ),
            SizedBox(
              height: Adapt.px(50),
            ),
          ],
        ),
      ),
    );
  }

  return _buildStill();
}
