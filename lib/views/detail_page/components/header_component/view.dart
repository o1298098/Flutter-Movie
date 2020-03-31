import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/customwidgets/scrollview_background.dart';
import 'package:movie/customwidgets/shimmercell.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/detail_page/action.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
      Widget _buildExternalCell(String icon, String url, String id) {
        return id != null
            ? InkWell(
                borderRadius: BorderRadius.circular(Adapt.px(20)),
                onTap: () => dispatch(
                    MovieDetailPageActionCreator.onExternalTapped(url + id)),
                child: Container(
                  width: Adapt.px(40),
                  height: Adapt.px(40),
                  child: Image.asset(
                    icon,
                    color: _theme.iconTheme.color,
                  ),
                ),
              )
            : Container();
      }

      Widget _getExternal() {
        var _detail = state.detail;
        var _ids = _detail.externalIds;
        if (_ids != null)
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _buildExternalCell('images/facebook_circle.png',
                  'https://www.facebook.com/', _ids.facebookId),
              SizedBox(
                width: Adapt.px(10),
              ),
              _buildExternalCell('images/twitter_circle.png',
                  'https://twitter.com/', _ids.twitterId),
              SizedBox(
                width: Adapt.px(10),
              ),
              _buildExternalCell('images/instagram_circle.png',
                  'https://www.instagram.com/', _ids.instagramId),
              SizedBox(
                width: Adapt.px(20),
              ),
              (_ids.facebookId == null &&
                          _ids.twitterId == null &&
                          _ids.instagramId == null) ||
                      _detail.homepage == null
                  ? Container()
                  : Container(
                      width: Adapt.px(2),
                      height: Adapt.px(30),
                      color: Colors.grey,
                    ),
              SizedBox(
                width: Adapt.px(20),
              ),
              _detail.homepage != null
                  ? InkWell(
                      borderRadius: BorderRadius.circular(Adapt.px(15)),
                      onTap: () => dispatch(
                          MovieDetailPageActionCreator.onExternalTapped(
                              _detail.homepage)),
                      child: Container(
                        width: Adapt.px(30),
                        height: Adapt.px(30),
                        child: Image.asset('images/link_bold.png',
                            color: _theme.iconTheme.color),
                      ))
                  : SizedBox(),
            ],
          );
        else
          return Row(
            children: <Widget>[
              ShimmerCell(Adapt.px(60), Adapt.px(60), Adapt.px(30),
                  baseColor: _theme.primaryColorDark,
                  highlightColor: _theme.primaryColorLight),
              SizedBox(
                width: Adapt.px(20),
              ),
              ShimmerCell(Adapt.px(60), Adapt.px(60), Adapt.px(30),
                  baseColor: _theme.primaryColorDark,
                  highlightColor: _theme.primaryColorLight),
              SizedBox(
                width: Adapt.px(20),
              ),
              ShimmerCell(Adapt.px(60), Adapt.px(60), Adapt.px(30),
                  baseColor: _theme.primaryColorDark,
                  highlightColor: _theme.primaryColorLight)
            ],
          );
      }

      Widget _buildHeader() {
        Widget _bg = state.bgPic == null
            ? Container(
                key: ValueKey('bgEmpty'),
              )
            : Container(
                width: Adapt.screenW(),
                key: ValueKey(state.bgPic),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          ImageUrl.getUrl(state.bgPic, ImageSize.w500))),
                ),
                child: ScrollViewBackGround(
                  scrollController: state.scrollController,
                  height: Adapt.px(750).floorToDouble(),
                  maxOpacity: 0.8,
                ));
        Widget _headerTitle = state.detail?.title == null
            ? Shimmer.fromColors(
                baseColor: _theme.primaryColorDark,
                highlightColor: _theme.primaryColorLight,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: Adapt.px(400),
                      height: Adapt.px(40),
                      color: _theme.primaryColorDark,
                    ),
                    SizedBox(
                      height: Adapt.px(10),
                    ),
                    Container(
                      width: Adapt.px(120),
                      height: Adapt.px(24),
                      color: _theme.primaryColorDark,
                    ),
                    SizedBox(
                      height: Adapt.px(10),
                    ),
                    Container(
                      width: Adapt.px(200),
                      height: Adapt.px(24),
                      color: _theme.primaryColorDark,
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: Adapt.px(600),
                    child: Text(
                      state.detail?.title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: Adapt.px(40), fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: Adapt.px(10),
                  ),
                  Text(DateFormat.yMMMd().format(DateTime.parse(
                      state.detail?.releaseDate?.isEmpty == true
                          ? '1990-01-01'
                          : state.detail?.releaseDate))),
                  SizedBox(
                    height: Adapt.px(10),
                  ),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.grey),
                        children: <TextSpan>[
                          TextSpan(
                              text: state.detail?.genres
                                      ?.map((f) {
                                        return f.name;
                                      })
                                      ?.toList()
                                      ?.take(3)
                                      ?.join(' / ') ??
                                  ''),
                          TextSpan(text: ' · '),
                          TextSpan(
                              text: _covertDuration(state.detail?.runtime ?? 0))
                        ]),
                  ),
                  SizedBox(
                    height: Adapt.px(10),
                  ),
                  Row(
                    children: <Widget>[
                      RatingBarIndicator(
                        rating: (state.detail?.voteAverage ?? 0.0) / 2,
                        itemPadding: EdgeInsets.only(right: Adapt.px(8)),
                        itemCount: 5,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        unratedColor: Colors.grey,
                        itemSize: Adapt.px(25),
                      ),
                      SizedBox(
                        width: Adapt.px(8),
                      ),
                      Text(
                        '${state.detail?.voteAverage ?? 0.0}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: Adapt.px(8),
                      ),
                      Text('(${state.detail?.voteCount ?? 0})'),
                    ],
                  ),
                ],
              );
        return SliverAppBar(
          elevation: 10.0,
          backgroundColor: Colors.blueGrey,
          pinned: true,
          expandedHeight: Adapt.px(1100).floorToDouble(),
          actions: <Widget>[
            IconButton(
              onPressed: () =>
                  dispatch(MovieDetailPageActionCreator.openMenu()),
              icon: Icon(Icons.more_vert),
            )
          ],
          flexibleSpace: AnimatedSwitcher(
            duration: Duration(milliseconds: 600),
            child: _bg,
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(Adapt.px(300)),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                Container(
                    width: Adapt.screenW(),
                    height: Adapt.px(250),
                    padding: EdgeInsets.fromLTRB(
                        Adapt.px(40), Adapt.px(40), Adapt.px(40), 0),
                    decoration: BoxDecoration(
                        color: _theme.backgroundColor,
                        border: Border.all(color: _theme.backgroundColor),
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(Adapt.px(50)))),
                    child: _headerTitle),
                Container(
                  margin: EdgeInsets.only(
                      right: Adapt.px(60), bottom: Adapt.px(200)),
                  width: Adapt.px(100),
                  height: Adapt.px(100),
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    color:
                        state.hasStreamLink == true ? Colors.red : Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Adapt.px(50))),
                    highlightColor: Colors.red,
                    child: Icon(
                      Icons.play_arrow,
                      color: const Color(0xFFFFFFFF),
                      size: Adapt.px(45),
                    ),
                    onPressed: () =>
                        dispatch(MovieDetailPageActionCreator.playTrailer()),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: Adapt.px(30), right: Adapt.px(40)),
                  width: Adapt.px(250),
                  child: _getExternal(),
                )
              ],
            ),
          ),
        );
      }

      return _buildHeader();
    },
  );
}

String _covertDuration(int d) {
  String result = '';
  Duration duration = Duration(minutes: d);
  int h = duration.inHours;
  int countedMin = h * 60;
  int m = duration.inMinutes - countedMin;
  result += h > 0 ? '$h h ' : '';
  result += '$m min';
  return result;
}
