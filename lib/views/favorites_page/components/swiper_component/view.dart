import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/customwidgets/shimmercell.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/base_api_model/user_media.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SwiperState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  Widget _buildListCell(UserMedia d) {
    return Container(
      key: ValueKey(d),
      //margin: EdgeInsets.all(Adapt.px(20)),
      width: Adapt.px(200),
      decoration: BoxDecoration(
          color: _theme.primaryColorDark,
          borderRadius: BorderRadius.circular(Adapt.px(20)),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(
                  ImageUrl.getUrl(d.photoUrl, ImageSize.w500)))),
    );
  }

  Widget _buildSwiper() {
    var height = (Adapt.screenW() * 0.55 - Adapt.px(40)) * 1.7;
    UserMediaModel d = state.isMovie ? state.movies : state.tvshows;
    Widget bodychild = d?.data != null
        ? Container(
            key: ValueKey(d),
            height: height,
            child: Swiper(
              loop: false,
              scale: 0.65,
              fade: 0.1,
              viewportFraction: 0.55,
              itemBuilder: (BuildContext context, int index) {
                return _buildListCell(d.data[index]);
              },
              itemCount: d?.data?.length ?? 0,
              onIndexChanged: (index) {
                var r = d.data[index];
                dispatch(SwiperActionCreator.setBackground(r));
                state.animationController.forward(from: 0.0);
              },
            ),
          )
        : Container(
            height: height,
            child: Swiper(
              loop: false,
              scale: 0.65,
              viewportFraction: 0.55,
              itemBuilder: (BuildContext context, int index) {
                return ShimmerCell(Adapt.px(300), height, Adapt.px(20));
              },
              itemCount: 3,
            ));
    return AnimatedSwitcher(
        switchOutCurve: Curves.easeOut,
        switchInCurve: Curves.easeIn,
        duration: Duration(milliseconds: 300),
        child: bodychild);
  }

  Widget _buildSwitchTitle() {
    TextStyle selectTextStyle =
        TextStyle(fontSize: Adapt.px(30), fontWeight: FontWeight.bold);
    TextStyle unSelectTextStyle = TextStyle(fontSize: Adapt.px(30));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              dispatch(SwiperActionCreator.mediaTpyeChanged(true));
              state.animationController.forward(from: 0.0);
            },
            child: Text(
              I18n.of(viewService.context).movies,
              style: state.isMovie ? selectTextStyle : unSelectTextStyle,
            ),
          ),
          SizedBox(
            width: Adapt.px(30),
          ),
          GestureDetector(
            onTap: () {
              dispatch(SwiperActionCreator.mediaTpyeChanged(false));
              state.animationController.forward(from: 0.0);
            },
            child: Text(
              I18n.of(viewService.context).tvShows,
              style: state.isMovie ? unSelectTextStyle : selectTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  return Column(
    children: <Widget>[
      _buildSwitchTitle(),
      SizedBox(height: Adapt.px(40)),
      _buildSwiper(),
    ],
  );
}
