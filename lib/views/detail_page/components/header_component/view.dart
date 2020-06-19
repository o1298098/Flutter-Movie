import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/widgets/scrollview_background.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/externalidsmodel.dart';
import 'package:movie/models/moviedetail.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/detail_page/action.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      return SliverAppBar(
        elevation: 10.0,
        backgroundColor: Colors.blueGrey,
        pinned: true,
        expandedHeight: Adapt.px(1100).floorToDouble(),
        actions: <Widget>[
          IconButton(
            onPressed: () => dispatch(MovieDetailPageActionCreator.openMenu()),
            icon: Icon(Icons.more_vert),
          )
        ],
        flexibleSpace: AnimatedSwitcher(
          duration: Duration(milliseconds: 600),
          child: _BackGround(
            imgUrl: state.bgPic,
            scrollController: state.scrollController,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(Adapt.px(300)),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              _HeaderTitle(
                title: state.detail?.title,
                releaseDate: state.detail?.releaseDate,
                genres: state.detail?.genres ?? [],
                voteAverage: state.detail?.voteAverage ?? 0,
                voteCount: state.detail?.voteCount ?? 0,
                runtime: state.detail?.runtime ?? 0,
              ),
              _PlayButton(
                dispatch: dispatch,
                hasStreamLink: state.hasStreamLink,
              ),
              _ExternalGroup(
                dispatch: dispatch,
                externalIds: state.detail.externalIds,
                homePage: state.detail.homepage,
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _HeaderTitleShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Shimmer.fromColors(
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
    );
  }
}

class _HeaderTitle extends StatelessWidget {
  final String title;
  final String releaseDate;
  final int runtime;
  final List<Genre> genres;
  final double voteAverage;
  final int voteCount;
  const _HeaderTitle({
    this.title,
    this.releaseDate,
    this.genres,
    this.voteAverage,
    this.voteCount,
    this.runtime,
  });
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Container(
      width: Adapt.screenW(),
      height: Adapt.px(250),
      padding: EdgeInsets.fromLTRB(Adapt.px(40), Adapt.px(40), Adapt.px(40), 0),
      decoration: BoxDecoration(
          color: _theme.backgroundColor,
          border: Border.all(color: _theme.backgroundColor),
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(Adapt.px(50)))),
      child: title == null
          ? _HeaderTitleShimmer()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: Adapt.px(600),
                  child: Text(
                    title ?? '',
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
                    releaseDate?.isEmpty == true
                        ? '1990-01-01'
                        : releaseDate))),
                SizedBox(
                  height: Adapt.px(10),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.grey),
                    children: <TextSpan>[
                      TextSpan(
                          text: genres
                                  ?.map((f) {
                                    return f.name;
                                  })
                                  ?.toList()
                                  ?.take(3)
                                  ?.join(' / ') ??
                              ''),
                      TextSpan(text: ' · '),
                      TextSpan(text: _covertDuration(runtime ?? 0))
                    ],
                  ),
                ),
                SizedBox(
                  height: Adapt.px(10),
                ),
                Row(
                  children: <Widget>[
                    RatingBarIndicator(
                      rating: (voteAverage ?? 0.0) / 2,
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
                      '${voteAverage ?? 0.0}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: Adapt.px(8),
                    ),
                    Text('(${voteCount ?? 0})'),
                  ],
                ),
              ],
            ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  final bool hasStreamLink;
  final Dispatch dispatch;
  const _PlayButton({this.dispatch, this.hasStreamLink});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: Adapt.px(60), bottom: Adapt.px(200)),
      width: Adapt.px(100),
      height: Adapt.px(100),
      child: FlatButton(
        padding: EdgeInsets.zero,
        color: hasStreamLink == true ? Colors.red : Colors.grey,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Adapt.px(50))),
        highlightColor: Colors.red,
        child: Icon(
          Icons.play_arrow,
          color: const Color(0xFFFFFFFF),
          size: Adapt.px(45),
        ),
        onPressed: () => dispatch(MovieDetailPageActionCreator.playTrailer()),
      ),
    );
  }
}

class _BackGround extends StatelessWidget {
  final String imgUrl;
  final ScrollController scrollController;
  const _BackGround({this.imgUrl, this.scrollController});
  @override
  Widget build(BuildContext context) {
    return imgUrl == null
        ? Container(
            key: ValueKey('bgEmpty'),
            width: Adapt.screenW(),
          )
        : Container(
            width: Adapt.screenW(),
            key: ValueKey(imgUrl),
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                      ImageUrl.getUrl(imgUrl, ImageSize.w500))),
            ),
            child: ScrollViewBackGround(
              scrollController: scrollController,
              height: Adapt.px(750).floorToDouble(),
              maxOpacity: 0.8,
            ));
  }
}

class _ExternalShimmerCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: Row(
          children: <Widget>[
            Container(
              width: Adapt.px(60),
              height: Adapt.px(60),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(width: Adapt.px(20)),
            Container(
              width: Adapt.px(60),
              height: Adapt.px(60),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: const Color(0xFFFFFFFF)),
            ),
            SizedBox(width: Adapt.px(20)),
            Container(
              width: Adapt.px(60),
              height: Adapt.px(60),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: const Color(0xFFFFFFFF)),
            )
          ],
        ));
  }
}

class _ExternalCell extends StatelessWidget {
  final String icon;
  final String url;
  final String id;
  final Dispatch dispatch;
  const _ExternalCell({this.icon, this.url, this.id, this.dispatch});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
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
}

class _ExternalGroup extends StatelessWidget {
  final String homePage;
  final ExternalIdsModel externalIds;
  final Dispatch dispatch;
  const _ExternalGroup({this.externalIds, this.homePage, this.dispatch});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Container(
      margin: EdgeInsets.only(bottom: Adapt.px(30), right: Adapt.px(40)),
      width: Adapt.px(250),
      child: externalIds != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _ExternalCell(
                  icon: 'images/facebook_circle.png',
                  url: 'https://www.facebook.com/',
                  id: externalIds.facebookId,
                  dispatch: dispatch,
                ),
                SizedBox(width: Adapt.px(10)),
                _ExternalCell(
                  icon: 'images/twitter_circle.png',
                  url: 'https://twitter.com/',
                  id: externalIds.twitterId,
                  dispatch: dispatch,
                ),
                SizedBox(width: Adapt.px(10)),
                _ExternalCell(
                  icon: 'images/instagram_circle.png',
                  url: 'https://www.instagram.com/',
                  id: externalIds.instagramId,
                  dispatch: dispatch,
                ),
                SizedBox(width: Adapt.px(20)),
                (externalIds.facebookId == null &&
                            externalIds.twitterId == null &&
                            externalIds.instagramId == null) ||
                        homePage == null
                    ? Container()
                    : Container(
                        width: Adapt.px(2),
                        height: Adapt.px(30),
                        color: Colors.grey,
                      ),
                SizedBox(
                  width: Adapt.px(20),
                ),
                homePage != null
                    ? InkWell(
                        borderRadius: BorderRadius.circular(Adapt.px(15)),
                        onTap: () => dispatch(
                            MovieDetailPageActionCreator.onExternalTapped(
                                homePage)),
                        child: Container(
                          width: Adapt.px(30),
                          height: Adapt.px(30),
                          child: Image.asset('images/link_bold.png',
                              color: _theme.iconTheme.color),
                        ))
                    : SizedBox(),
              ],
            )
          : _ExternalShimmerCell(),
    );
  }
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
