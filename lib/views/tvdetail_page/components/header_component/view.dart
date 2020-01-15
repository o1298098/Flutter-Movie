import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/actions/votecolorhelper.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/tvdetail_page/action.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
  final s = state.tvDetailModel;
  final dominantColor = state.mainColor;
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  double evote = 0.0;
  Widget _getTitle() {
    if (state.name == null)
      return SizedBox(
          child: Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: Container(
          height: Adapt.px(50),
          width: Adapt.px(200),
          color: Colors.grey[200],
        ),
      ));
    else
      return RichText(
        text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: state.name,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: Adapt.px(50),
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 2.0,
                      color: Colors.black,
                    ),
                  ])),
          TextSpan(
              text: s.name == null
                  ? ' (-)'
                  : ' (${DateTime.tryParse(s.firstAirDate)?.year.toString()})',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: Adapt.px(30),
                  color: Colors.grey[400],
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 2.0,
                      color: Colors.black,
                    ),
                  ])),
        ]),
      );
  }

  Widget _getPosterPic() {
    if (state.posterPic == null)
      return SizedBox(
          child: Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: Container(
          height: Adapt.px(300),
          width: Adapt.px(200),
          color: Colors.grey[400],
        ),
      ));
    else
      return Card(
        elevation: 20.0,
        child: CachedNetworkImage(
          height: Adapt.px(300),
          width: Adapt.px(200),
          fit: BoxFit.cover,
          imageUrl: ImageUrl.getUrl(state.posterPic, ImageSize.w300),
          placeholder: (c, s) {
            return Container(
              height: Adapt.px(300),
              width: Adapt.px(200),
              color: Colors.grey,
            );
          },
        ),
      );
  }

  Widget _buildHeader() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            width: Adapt.screenW(),
            height: Adapt.px(400),
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter:
                        ColorFilter.mode(dominantColor, BlendMode.color),
                    image: CachedNetworkImageProvider(state.backdropPic == null
                        ? ImageUrl.emptyimage
                        : ImageUrl.getUrl(state.backdropPic, ImageSize.w500)),
                    fit: BoxFit.cover)),
          ),
          Container(
            width: Adapt.screenW(),
            height: Adapt.px(401),
            color: dominantColor.withOpacity(.8),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.fromLTRB(
                Adapt.px(30), Adapt.px(180), Adapt.px(30), Adapt.px(220)),
            child: Row(
              children: <Widget>[
                _getPosterPic(),
                SizedBox(
                  width: Adapt.px(20),
                ),
                Container(
                  padding: EdgeInsets.only(top: Adapt.px(150)),
                  width: Adapt.screenW() * 0.6,
                  child: _getTitle(),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(bottom: Adapt.px(120)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      AnimatedBuilder(
                        animation: state.animationController,
                        builder: (ctx, widget) {
                          var animate = Tween<double>(
                                  begin: 0.0, end: s.voteAverage ?? evote)
                              .animate(CurvedAnimation(
                                parent: state.animationController,
                                curve: Curves.ease,
                              ))
                              .value;
                          return Stack(
                            children: <Widget>[
                              Container(
                                  width: Adapt.px(80),
                                  height: Adapt.px(80),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(Adapt.px(40))),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 6.0,
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            VoteColorHelper.getColor(animate)),
                                    backgroundColor: Colors.grey,
                                    value: animate / 10,
                                  )),
                              Container(
                                  width: Adapt.px(80),
                                  height: Adapt.px(80),
                                  child: Center(
                                    child: Text(
                                      (animate * 10).floor().toString() + '%',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: Adapt.px(28),
                                          color: Colors.white),
                                    ),
                                  ))
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        width: Adapt.px(30),
                      ),
                      Text(I18n.of(viewService.context).userScore,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: Adapt.px(30),
                              color: Colors.white))
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: Adapt.px(40),
                  color: Colors.grey[400],
                ),
                InkWell(
                  onTap: () =>
                      dispatch(TVDetailPageActionCreator.onPlayTapped()),
                  child: Container(
                    width: Adapt.px(180),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.play_arrow, color: Colors.white),
                        SizedBox(
                          width: Adapt.px(10),
                        ),
                        Text(I18n.of(viewService.context).play,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: Adapt.px(30),
                                color: Colors.white))
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  return _buildHeader();
}
