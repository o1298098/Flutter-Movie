import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/videolist.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/home_page/action.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  Widget _buildHeaderTitel() {
    var _selectTextStyle = TextStyle(
        color: Colors.white,
        fontSize: Adapt.px(40),
        fontWeight: FontWeight.bold);
    var _unselectTextStyle =
        TextStyle(color: Colors.grey, fontSize: Adapt.px(40));
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            InkWell(
              onTap: () =>
                  dispatch(HeaderActionCreator.onHeaderFilterChanged(true)),
              child: Text(I18n.of(viewService.context).inTheaters,
                  style: state.showHeaderMovie
                      ? _selectTextStyle
                      : _unselectTextStyle),
            ),
            SizedBox(
              width: Adapt.px(30),
            ),
            InkWell(
              onTap: () =>
                  dispatch(HeaderActionCreator.onHeaderFilterChanged(false)),
              child: Text(
                I18n.of(viewService.context).onTV,
                style: state.showHeaderMovie
                    ? _unselectTextStyle
                    : _selectTextStyle,
              ),
            )
          ],
        ));
  }

  Widget _buildHeaderListCell(VideoListResult f) {
    String name = f.title ?? f.name;
    return Padding(
        key: ValueKey('headercell' + f.id.toString()),
        padding: EdgeInsets.only(left: Adapt.px(30)),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () => dispatch(HomePageActionCreator.onCellTapped(
                  f.id,
                  f.backdropPath,
                  name,
                  f.posterPath,
                  state.showHeaderMovie ? MediaType.movie : MediaType.tv)),
              child: Container(
                width: Adapt.px(200),
                height: Adapt.px(280),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(57, 57, 57, 1),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                            ImageUrl.getUrl(f.posterPath, ImageSize.w300)))),
              ),
            ),
            SizedBox(
              height: Adapt.px(20),
            ),
            Container(
              alignment: Alignment.center,
              width: Adapt.px(200),
              height: Adapt.px(70),
              child: Text(name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: Adapt.px(26))),
            ),
          ],
        ));
  }

  Widget _buildShimmerHeaderCell() {
    Color _baseColor = Color.fromRGBO(57, 57, 57, 1);
    Color _highLightColor = Color.fromRGBO(67, 67, 67, 1);
    return Shimmer.fromColors(
        baseColor: _baseColor,
        highlightColor: _highLightColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: Adapt.px(200),
              height: Adapt.px(280),
              color: _baseColor,
            ),
            SizedBox(
              height: Adapt.px(20),
            ),
            Container(
              width: Adapt.px(200),
              height: Adapt.px(20),
              color: _baseColor,
            ),
            SizedBox(
              height: Adapt.px(8),
            ),
            Container(
              width: Adapt.px(150),
              height: Adapt.px(20),
              color: _baseColor,
            ),
          ],
        ));
  }

  Widget _buildHeaderBody() {
    var _model = state.showHeaderMovie ? state.movie : state.tv;
    return Container(
      height: Adapt.px(400),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 600),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        child: ListView(
            key: ValueKey(_model),
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: _model.results.length > 0
                ? _model.results.map(_buildHeaderListCell).toList()
                : <Widget>[
                    SizedBox(
                      width: Adapt.px(30),
                    ),
                    _buildShimmerHeaderCell(),
                    SizedBox(
                      width: Adapt.px(30),
                    ),
                    _buildShimmerHeaderCell(),
                    SizedBox(
                      width: Adapt.px(30),
                    ),
                    _buildShimmerHeaderCell(),
                  ]),
      ),
    );
  }

  return Container(
    color: _theme.bottomAppBarColor,
    child: Column(
      children: <Widget>[
        SizedBox(
          height: Adapt.px(30),
        ),
        _buildHeaderTitel(),
        SizedBox(
          height: Adapt.px(45),
        ),
        _buildHeaderBody()
      ],
    ),
  );
}
