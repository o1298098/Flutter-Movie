import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/widgets/shimmercell.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/base_api_model/user_media.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SwiperState state, Dispatch dispatch, ViewService viewService) {
  final UserMediaModel _d = state.isMovie ? state.movies : state.tvshows;

  return Column(
    children: <Widget>[
      _SwitchTitle(
        controller: state.animationController,
        isMovie: state.isMovie,
        onTabChanged: (b) => dispatch(SwiperActionCreator.mediaTpyeChanged(b)),
      ),
      SizedBox(height: Adapt.px(40)),
      _Swiper(
        data: _d?.data,
        controller: state.animationController,
        dispatch: dispatch,
      )
    ],
  );
}

class _SwitchTitle extends StatelessWidget {
  final Function(bool) onTabChanged;
  final AnimationController controller;
  final bool isMovie;
  const _SwitchTitle({this.onTabChanged, this.controller, this.isMovie});
  @override
  Widget build(BuildContext context) {
    final TextStyle selectTextStyle =
        TextStyle(fontSize: Adapt.px(30), fontWeight: FontWeight.bold);
    final TextStyle unSelectTextStyle = TextStyle(fontSize: Adapt.px(30));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              onTabChanged(true);
              controller.forward(from: 0.0);
            },
            child: Text(
              I18n.of(context).movies,
              style: isMovie ? selectTextStyle : unSelectTextStyle,
            ),
          ),
          SizedBox(
            width: Adapt.px(30),
          ),
          GestureDetector(
            onTap: () {
              onTabChanged(false);
              controller.forward(from: 0.0);
            },
            child: Text(
              I18n.of(context).tvShows,
              style: isMovie ? unSelectTextStyle : selectTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class _ListCell extends StatelessWidget {
  final UserMedia data;
  final Function(UserMedia) onTap;
  const _ListCell({this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return GestureDetector(
      onTap: () => onTap(data),
      child: Container(
        key: ValueKey(data),
        width: Adapt.px(200),
        decoration: BoxDecoration(
          color: _theme.primaryColorDark,
          borderRadius: BorderRadius.circular(Adapt.px(20)),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(
              ImageUrl.getUrl(data.photoUrl, ImageSize.w500),
            ),
          ),
        ),
      ),
    );
  }
}

class _Swiper extends StatelessWidget {
  final List<UserMedia> data;
  final AnimationController controller;
  final Dispatch dispatch;
  const _Swiper({this.data, this.controller, this.dispatch});
  @override
  Widget build(BuildContext context) {
    final height = (Adapt.screenW() * 0.55 - Adapt.px(40)) * 1.7;
    return AnimatedSwitcher(
      switchOutCurve: Curves.easeOut,
      switchInCurve: Curves.easeIn,
      duration: Duration(milliseconds: 300),
      child: data != null
          ? Container(
              key: ValueKey(data),
              height: height,
              child: Swiper(
                loop: false,
                scale: 0.65,
                fade: 0.1,
                viewportFraction: 0.55,
                itemBuilder: (BuildContext context, int index) {
                  return _ListCell(
                    data: data[index],
                    onTap: (d) => dispatch(SwiperActionCreator.cellTapped(d)),
                  );
                },
                itemCount: data?.length ?? 0,
                onIndexChanged: (index) {
                  var r = data[index];
                  dispatch(SwiperActionCreator.setBackground(r));
                  controller.forward(from: 0.0);
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
              ),
            ),
    );
  }
}
