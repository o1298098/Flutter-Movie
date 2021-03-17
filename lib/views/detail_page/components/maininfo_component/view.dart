import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/genre.dart';
import 'package:movie/widgets/scrollview_background.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/external_ids_model.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/detail_page/action.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(
    MainInfoState state, Dispatch dispatch, ViewService viewService) {
  final _height = Adapt.px(1150);
  return Builder(
    builder: (context) {
      return SliverToBoxAdapter(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 600),
              child: SizedBox(
                height: _height,
                child: _HeaderBackground(
                  imgUrl: state.bgPic,
                  scrollController: state.scrollController,
                ),
              ),
            ),
            _HeaderTitle(
              title: state.detail?.title,
              releaseDate: state.detail?.releaseDate,
              genres: state.detail?.genres ?? [],
              voteAverage: state.detail?.voteAverage ?? 0,
              voteCount: state.detail?.voteCount ?? 0,
              runtime: state.detail?.runtime ?? 0,
            ),
            _OperatePanel(
              dispatch: dispatch,
              hasStreamLink: state.hasStreamLink,
              externalIds: state.detail.externalIds,
              homePage: state.detail.homepage,
            ),
          ],
        ),
      );
    },
  );
}

class _HeaderTitleShimmer extends StatelessWidget {
  const _HeaderTitleShimmer();
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
          //border: Border.all(color: _theme.backgroundColor),
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(Adapt.px(50)))),
      child: title == null
          ? const _HeaderTitleShimmer()
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
      margin: EdgeInsets.only(
        right: Adapt.px(60),
      ),
      width: Adapt.px(100),
      height: Adapt.px(100),
      child: TextButton(
        style: TextButton.styleFrom( padding: EdgeInsets.zero,
        backgroundColor: hasStreamLink == true ? Colors.red : Colors.grey,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Adapt.px(50))),
        ),
       
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

class _OperatePanel extends StatelessWidget {
  final bool hasStreamLink;
  final Dispatch dispatch;
  final String homePage;
  final ExternalIdsModel externalIds;
  const _OperatePanel(
      {this.dispatch, this.externalIds, this.hasStreamLink, this.homePage});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adapt.px(300),
      width: Adapt.screenW(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        _PlayButton(
          dispatch: dispatch,
          hasStreamLink: hasStreamLink,
        ),
        Spacer(),
        _ExternalGroup(
          dispatch: dispatch,
          externalIds: externalIds,
          homePage: homePage,
        )
      ]),
    );
  }
}

class _HeaderBackground extends StatefulWidget {
  final String imgUrl;
  final ScrollController scrollController;
  const _HeaderBackground({this.imgUrl, this.scrollController});
  @override
  _HeaderBackgroundState createState() => _HeaderBackgroundState();
}

class _HeaderBackgroundState extends State<_HeaderBackground> {
  double postion = 0;
  final _height = Adapt.px(1150).floorToDouble();
  void _imageScroll() {
    if (widget.scrollController.position.pixels <= _height)
      postion = widget.scrollController.position.pixels;
    setState(() {});
  }

  @override
  void initState() {
    widget.scrollController.addListener(_imageScroll);
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_imageScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.imgUrl == null
        ? Container(
            key: ValueKey('bgEmpty'),
            color: const Color(0xFF607D8B),
            width: Adapt.screenW(),
          )
        : Stack(
            children: [
              Container(
                width: Adapt.screenW(),
                key: ValueKey(widget.imgUrl),
                transform: Matrix4.translationValues(0, postion, 0),
                height: _height - postion,
                decoration: BoxDecoration(
                  color: const Color(0xFF607D8B),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      ImageUrl.getUrl(widget.imgUrl, ImageSize.w500),
                    ),
                  ),
                ),
              ),
              ScrollViewBackGround(
                scrollController: widget.scrollController,
                height: Adapt.px(750).floorToDouble(),
                maxOpacity: 0.8,
              )
            ],
          );
  }
}

class _ExternalShimmerCell extends StatelessWidget {
  const _ExternalShimmerCell();
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
                  shape: BoxShape.circle, color: const Color(0xFFFFFFFF)),
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
                shape: BoxShape.circle,
                color: const Color(0xFFFFFFFF),
              ),
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
          : const _ExternalShimmerCell(),
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
