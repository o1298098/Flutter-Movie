import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/customwidgets/scrollview_background.dart';
import 'package:movie/customwidgets/shimmercell.dart';
import 'package:movie/customwidgets/sliverappbar_delegate.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/creditsmodel.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:movie/models/keyword.dart';
import 'package:movie/models/videolist.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MovieDetailPageState state, Dispatch dispatch, ViewService viewService) {
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

  Widget _buildRecommendationShimmerCell() {
    double _width = Adapt.px(220);
    return SizedBox(
      width: _width,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: _width,
              height: Adapt.px(320),
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
            ),
            SizedBox(
              height: Adapt.px(15),
            ),
            Container(
              width: _width,
              height: Adapt.px(30),
              color: Colors.grey[200],
            ),
            SizedBox(
              height: Adapt.px(8),
            ),
            Container(
              width: _width - Adapt.px(50),
              height: Adapt.px(30),
              color: Colors.grey[200],
            ),
            SizedBox(
              height: Adapt.px(8),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String url, double width, double height, double radius,
      {EdgeInsetsGeometry margin = EdgeInsets.zero, ValueKey key}) {
    return Container(
      key: key,
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(radius),
          image: DecorationImage(
              fit: BoxFit.cover, image: CachedNetworkImageProvider(url))),
    );
  }

  Widget _buildExternalCell(String icon, String url, String id) {
    return id != null
        ? InkWell(
            borderRadius: BorderRadius.circular(Adapt.px(20)),
            onTap: () =>
                dispatch(MovieDetailPageActionCreator.onExternalTapped(url)),
            child: Container(
              width: Adapt.px(40),
              height: Adapt.px(40),
              child: Image.asset(
                icon,
              ),
            ),
          )
        : Container();
  }

  Widget _getExternal() {
    var _detail = state.detail;
    var _ids = _detail.externalids;
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
                    child: Image.asset(
                      'images/link_bold.png',
                    ),
                  ))
              : SizedBox(),
        ],
      );
    else
      return Row(
        children: <Widget>[
          ShimmerCell(Adapt.px(60), Adapt.px(60), Adapt.px(30)),
          SizedBox(
            width: Adapt.px(20),
          ),
          ShimmerCell(Adapt.px(60), Adapt.px(60), Adapt.px(30)),
          SizedBox(
            width: Adapt.px(20),
          ),
          ShimmerCell(Adapt.px(60), Adapt.px(60), Adapt.px(30))
        ],
      );
  }

  Widget _buildCastCell(CastData d) {
    double width = Adapt.px(150);
    return GestureDetector(
      onTap: () => dispatch(MovieDetailPageActionCreator.castCellTapped(
          d.id, d.profile_path, d.name, d.character)),
      child: Column(
        key: ValueKey('Cast${d.id}'),
        children: <Widget>[
          Hero(
              tag: 'people${d.id}',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  margin: EdgeInsets.only(right: Adapt.px(30)),
                  width: width,
                  height: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Adapt.px(15)),
                      color: Colors.grey[200],
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(ImageUrl.getUrl(
                              d.profile_path, ImageSize.w300)))),
                ),
              )),
          SizedBox(
            height: Adapt.px(10),
          ),
          Container(
              width: width,
              child: Text(
                d.name ?? '',
                maxLines: 2,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )),
          Container(
              width: width,
              child: Text(
                d.character ?? '',
                maxLines: 2,
                style: TextStyle(color: Colors.grey, fontSize: Adapt.px(24)),
              ))
        ],
      ),
    );
  }

  Widget _buildCastShimmerCell() {
    double width = Adapt.px(150);
    return Shimmer.fromColors(
      baseColor: Colors.grey[200],
      highlightColor: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: Adapt.px(30)),
            width: width,
            height: width,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
          ),
          SizedBox(
            height: Adapt.px(10),
          ),
          Container(
            width: width,
            height: Adapt.px(24),
            color: Colors.grey[200],
          ),
          SizedBox(
            height: Adapt.px(10),
          ),
          Container(
            width: Adapt.px(100),
            height: Adapt.px(24),
            color: Colors.grey[200],
          )
        ],
      ),
    );
  }

  Widget _buildImageCell(ImageData d) {
    String url = ImageUrl.getUrl(d.file_path, ImageSize.w500);
    int index = state.imagesmodel.backdrops.indexOf(d);
    return GestureDetector(
      key: ValueKey('image${d.file_path}'),
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

  Widget _buildKeyWordCell(KeyWordData d) {
    return Chip(
      key: ValueKey('keyword${d.id}'),
      elevation: 3.0,
      backgroundColor: Colors.white,
      label: Text(d.name),
    );
  }

  Widget _buildRecommendationCell(VideoListResult d) {
    double _width = Adapt.px(220);
    return GestureDetector(
      key: ValueKey('recommendation${d.id}'),
      onTap: () => dispatch(
          MovieDetailPageActionCreator.movieCellTapped(d.id, d.poster_path)),
      child: Padding(
        padding: EdgeInsets.only(right: Adapt.px(30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildImage(ImageUrl.getUrl(d.poster_path, ImageSize.w500), _width,
                Adapt.px(320), Adapt.px(20)),
            SizedBox(
              height: Adapt.px(15),
            ),
            Container(
              width: _width,
              child: Text(
                d.title,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: Adapt.px(24)),
              ),
            ),
            SizedBox(
              height: Adapt.px(8),
            ),
            Text('${DateTime.parse(d.release_date ?? '1990-01-01').year}',
                style: TextStyle(fontSize: Adapt.px(24))),
            SizedBox(
              height: Adapt.px(8),
            ),
            Container(
                width: _width,
                child: FlutterRatingBarIndicator(
                  itemPadding: EdgeInsets.only(right: Adapt.px(5)),
                  itemSize: Adapt.px(25),
                  emptyColor: Colors.grey[300],
                  rating: d.vote_average / 2,
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    Color _baseColor = Colors.grey[200];
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
            baseColor: _baseColor,
            highlightColor: Colors.grey[100],
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: Adapt.px(400),
                  height: Adapt.px(40),
                  color: _baseColor,
                ),
                SizedBox(
                  height: Adapt.px(10),
                ),
                Container(
                  width: Adapt.px(120),
                  height: Adapt.px(24),
                  color: _baseColor,
                ),
                SizedBox(
                  height: Adapt.px(10),
                ),
                Container(
                  width: Adapt.px(200),
                  height: Adapt.px(24),
                  color: _baseColor,
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
                      color: Colors.black,
                      fontSize: Adapt.px(40),
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: Adapt.px(10),
              ),
              Text(DateFormat.yMMMd().format(
                  DateTime.parse(state.detail?.release_date ?? '1990-01-01'))),
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
                  FlutterRatingBarIndicator(
                    rating: (state.detail?.vote_average ?? 0.0) / 2,
                    itemPadding: EdgeInsets.only(right: Adapt.px(8)),
                    itemCount: 5,
                    emptyColor: Colors.grey,
                    itemSize: Adapt.px(25),
                  ),
                  SizedBox(
                    width: Adapt.px(8),
                  ),
                  Text(
                    '${state.detail?.vote_average ?? 0.0}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: Adapt.px(8),
                  ),
                  Text('(${state.detail?.vote_count ?? 0})'),
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
          onPressed: () => dispatch(MovieDetailPageActionCreator.openMenu()),
          icon: Icon(Icons.more_vert),
        )
      ],
      flexibleSpace: AnimatedSwitcher(
        duration: Duration(milliseconds: 600),
        child: _bg,
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(Adapt.px(300).floorToDouble()),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Container(
                width: Adapt.screenW(),
                height: Adapt.px(250).floorToDouble(),
                padding: EdgeInsets.fromLTRB(
                    Adapt.px(40), Adapt.px(40), Adapt.px(40), 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.transparent, width: 0.0),
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(Adapt.px(50)))),
                child: _headerTitle),
            Container(
              margin:
                  EdgeInsets.only(right: Adapt.px(60), bottom: Adapt.px(200)),
              width: Adapt.px(100),
              height: Adapt.px(100),
              child: FlatButton(
                padding: EdgeInsets.zero,
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Adapt.px(50))),
                highlightColor: Colors.red,
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: Adapt.px(45),
                ),
                onPressed: () =>
                    dispatch(MovieDetailPageActionCreator.playTrailer()),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(bottom: Adapt.px(30), right: Adapt.px(40)),
              width: Adapt.px(250),
              child: _getExternal(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOverWatch() {
    Widget _overWatch = state.detail?.overview == null
        ? Shimmer.fromColors(
            baseColor: Colors.grey[200],
            highlightColor: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: Adapt.px(24),
                  color: Colors.grey[200],
                ),
                SizedBox(
                  height: Adapt.px(8),
                ),
                Container(
                  height: Adapt.px(24),
                  color: Colors.grey[200],
                ),
                SizedBox(
                  height: Adapt.px(8),
                ),
                Container(
                  height: Adapt.px(24),
                  color: Colors.grey[200],
                ),
                SizedBox(
                  height: Adapt.px(8),
                ),
                Container(
                  width: Adapt.px(300),
                  height: Adapt.px(24),
                  color: Colors.grey[200],
                )
              ],
            ),
          )
        : Text(state.detail?.overview ?? '');
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: Adapt.px(30),
            ),
            Text(
              I18n.of(viewService.context).overView,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: Adapt.px(35)),
            ),
            SizedBox(
              height: Adapt.px(20),
            ),
            _overWatch,
          ],
        ),
      ),
    );
  }

  Widget _buildCast() {
    var _model = state.detail?.credits?.cast ?? [];
    return SliverToBoxAdapter(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: Adapt.px(50),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
              child: Text(
                I18n.of(viewService.context).topBilledCast,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: Adapt.px(35)),
              ),
            ),
            SizedBox(
              height: Adapt.px(30),
            ),
            Container(
              height: Adapt.px(300),
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _model.length == 0
                      ? <Widget>[
                          SizedBox(
                            width: Adapt.px(40),
                          ),
                          _buildCastShimmerCell(),
                          SizedBox(
                            width: Adapt.px(30),
                          ),
                          _buildCastShimmerCell(),
                          SizedBox(
                            width: Adapt.px(30),
                          ),
                          _buildCastShimmerCell(),
                          SizedBox(
                            width: Adapt.px(30),
                          ),
                          _buildCastShimmerCell()
                        ]
                      : (state.detail.credits.cast.map(_buildCastCell).toList()
                        ..insert(
                            0,
                            SizedBox(
                              width: Adapt.px(40),
                            )))),
            )
          ],
        ),
      ),
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
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: Adapt.px(35)),
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
                              Adapt.px(320), Adapt.px(180), Adapt.px(20)),
                          SizedBox(
                            width: Adapt.px(30),
                          ),
                          ShimmerCell(
                              Adapt.px(320), Adapt.px(180), Adapt.px(20)),
                          SizedBox(
                            width: Adapt.px(30),
                          ),
                          ShimmerCell(
                              Adapt.px(320), Adapt.px(180), Adapt.px(20))
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

  Widget _buildKeyWord() {
    var _model = state.detail?.keywords?.keywords ?? [];
    return SliverToBoxAdapter(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
              child: Text(
                'KeyWords',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: Adapt.px(35)),
              ),
            ),
            SizedBox(
              height: Adapt.px(10),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  Adapt.px(40), 0, Adapt.px(40), Adapt.px(30)),
              child: Wrap(
                spacing: Adapt.px(15),
                direction: Axis.horizontal,
                children: _model.length == 0
                    ? <Widget>[
                        ShimmerCell(Adapt.px(120), Adapt.px(60), Adapt.px(30),
                            margin: EdgeInsets.only(top: Adapt.px(20))),
                        ShimmerCell(Adapt.px(180), Adapt.px(60), Adapt.px(30),
                            margin: EdgeInsets.only(top: Adapt.px(20))),
                        ShimmerCell(Adapt.px(200), Adapt.px(60), Adapt.px(30),
                            margin: EdgeInsets.only(top: Adapt.px(20))),
                      ]
                    : state.detail.keywords.keywords
                        .map(_buildKeyWordCell)
                        .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendations() {
    var _model = state.detail?.recommendations?.results ?? [];
    return SliverToBoxAdapter(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
            child: Text(
              I18n.of(viewService.context).recommendations,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: Adapt.px(35)),
            ),
          ),
          SizedBox(
            height: Adapt.px(30),
          ),
          Container(
            height: Adapt.px(450),
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: _model.length == 0
                    ? <Widget>[
                        SizedBox(
                          width: Adapt.px(40),
                        ),
                        _buildRecommendationShimmerCell(),
                        SizedBox(
                          width: Adapt.px(30),
                        ),
                        _buildRecommendationShimmerCell(),
                        SizedBox(
                          width: Adapt.px(30),
                        ),
                        _buildRecommendationShimmerCell()
                      ]
                    : (state.detail.recommendations.results
                        .map(_buildRecommendationCell)
                        .toList()
                          ..insert(
                              0,
                              SizedBox(
                                width: Adapt.px(40),
                              )))),
          ),
          SizedBox(
            height: Adapt.px(30),
          ),
        ]));
  }

  return Scaffold(
    key: state.scaffoldkey,
    backgroundColor: Colors.white,
    body: CustomScrollView(
      controller: state.scrollController,
      physics: ClampingScrollPhysics(),
      slivers: <Widget>[
        _buildHeader(),
        _buildOverWatch(),
        _buildCast(),
        _buildStill(),
        _buildKeyWord(),
        _buildRecommendations(),
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blueGrey[100],
                borderRadius: BorderRadius.circular(Adapt.px(50))),
            height: Adapt.px(800),
          ),
        ),
      ],
    ),
  );
}
