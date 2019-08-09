import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/customwidgets/customcliper_path.dart';
import 'package:movie/customwidgets/shimmercell.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/videolist.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    FavoritesPageState state, Dispatch dispatch, ViewService viewService) {
  Random random = Random(DateTime.now().millisecondsSinceEpoch);

  Widget _buildListCell(VideoListResult d) {
    return Container(
      key: ValueKey(d),
      //margin: EdgeInsets.all(Adapt.px(20)),
      width: Adapt.px(200),
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(Adapt.px(20)),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(
                  ImageUrl.getUrl(d.poster_path, ImageSize.w500)))),
    );
  }

  Widget _buildShimmerHeader() {
    Color _baseColor = Colors.grey[200];
    return Padding(
      padding: EdgeInsets.all(Adapt.px(30)),
      child: Shimmer.fromColors(
        baseColor: _baseColor,
        highlightColor: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: _baseColor,
              height: Adapt.px(40),
              width: Adapt.px(400),
            ),
            SizedBox(
              height: Adapt.px(15),
            ),
            Container(
              color: _baseColor,
              width: Adapt.px(300),
              height: Adapt.px(30),
            ),
            SizedBox(
              height: Adapt.px(15),
            ),
            Container(
              color: _baseColor,
              width: Adapt.screenW(),
              height: Adapt.px(26),
            ),
            SizedBox(
              height: Adapt.px(10),
            ),
            Container(
              color: _baseColor,
              width: Adapt.screenW(),
              height: Adapt.px(26),
            ),
            SizedBox(
              height: Adapt.px(10),
            ),
            Container(
              color: _baseColor,
              width: Adapt.screenW(),
              height: Adapt.px(26),
            ),
            SizedBox(
              height: Adapt.px(10),
            ),
            Container(
              color: _baseColor,
              width: Adapt.screenW(),
              height: Adapt.px(26),
            ),
            SizedBox(
              height: Adapt.px(10),
            ),
            Container(
              color: _baseColor,
              width: Adapt.px(600),
              height: Adapt.px(26),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconbutton(IconData icon) {
    return GestureDetector(
      child: Container(
        width: Adapt.px(60),
        height: Adapt.px(50),
        margin: EdgeInsets.only(right: Adapt.px(10)),
        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all()),
        child: Icon(
          icon,
          size: Adapt.px(30),
        ),
      ),
      onTap: () {},
    );
  }

  Widget _buildSwiper() {
    var height = (Adapt.screenW() * 0.55 - Adapt.px(40)) * 1.7;
    VideoListModel d =
        state.isMovie ? state.favoriteMovies : state.favoriteTVShows;
    Widget bodychild = d.results.length > 0
        ? Container(
            key: ValueKey(d),
            height: height,
            child: Swiper(
              loop: false,
              scale: 0.65,
              fade: 0.1,
              viewportFraction: 0.55,
              itemBuilder: (BuildContext context, int index) {
                return _buildListCell(d.results[index]);
              },
              itemCount: d.results.length,
              onIndexChanged: (index) {
                var r = d.results[index];
                dispatch(FavoritesPageActionCreator.setBackground(
                    r,
                    Color.fromRGBO(random.nextInt(200), random.nextInt(150),
                        random.nextInt(150), 1)));
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

  Widget _buildHeader() {
    final d = state.selectedMedia;
    if (d != null) {
      String name = d?.title ?? d?.name;
      String datetime = d?.release_date ?? d?.first_air_date;
      return FadeTransition(
          opacity:
              Tween(begin: 0.0, end: 1.0).animate(state.animationController),
          child: Container(
            height: Adapt.px(550),
            padding: EdgeInsets.all(Adapt.px(30)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name ?? '',
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Adapt.px(45),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: Adapt.px(10),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      DateFormat.yMMMd()
                          .format(DateTime.parse(datetime ?? '1990-01-01')),
                      style: TextStyle(fontSize: Adapt.px(26)),
                    ),
                    SizedBox(
                      width: Adapt.px(20),
                    ),
                    FlutterRatingBarIndicator(
                      itemSize: Adapt.px(30),
                      itemPadding:
                          EdgeInsets.symmetric(horizontal: Adapt.px(4)),
                      emptyColor: Colors.grey[400],
                      rating: (d?.vote_average ?? 0) / 2,
                    ),
                    SizedBox(
                      width: Adapt.px(10),
                    ),
                    Text(d?.vote_average?.toStringAsFixed(1) ?? '0.0',
                        style: TextStyle(fontSize: Adapt.px(26)))
                  ],
                ),
                SizedBox(
                  height: Adapt.px(10),
                ),
                Text(
                  d?.overview ?? '',
                  maxLines: 9,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: Adapt.px(28),
                  ),
                ),
              ],
            ),
          ));
    } else
      return _buildShimmerHeader();
  }

  Widget _buildSwitchTitle() {
    TextStyle selectTextStyle = TextStyle(
        color: Colors.black,
        fontSize: Adapt.px(30),
        fontWeight: FontWeight.bold);
    TextStyle unSelectTextStyle =
        TextStyle(color: Colors.black, fontSize: Adapt.px(30));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              dispatch(FavoritesPageActionCreator.mediaTpyeChanged(true));
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
              dispatch(FavoritesPageActionCreator.mediaTpyeChanged(false));
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

  return Scaffold(
    body: Stack(
      children: <Widget>[
      state.selectedMedia!=null? AnimatedSwitcher(
         duration: Duration(milliseconds: 800),
          child: CachedNetworkImage(
            key: ValueKey(state?.selectedMedia?.poster_path),
            imageUrl: ImageUrl.getUrl(
                state?.selectedMedia?.poster_path, ImageSize.w500),
            imageBuilder: (ctx, image) => Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black, BlendMode.color),
              image: image,
            ))),
            errorWidget: (ctx, str, object) => Container(),
          ),
        )
        :Container(),
        Container(
          color: Colors.white.withAlpha(230),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: Adapt.px(100),
                ),
                _buildHeader(),
                _buildSwitchTitle(),
                SizedBox(
                  height: Adapt.px(40),
                ),
                _buildSwiper(),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          child: AppBar(
            brightness: Brightness.light,
            titleSpacing: 0,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
            centerTitle: true,
            title: Text(
              'My Favorites',
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.sort),
              )
            ],
          ),
        )
      ],
    ),
  );
}
