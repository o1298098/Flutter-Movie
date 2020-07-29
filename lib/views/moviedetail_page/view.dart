import 'dart:collection';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/actions/videourl.dart';
import 'package:movie/actions/votecolorhelper.dart';
import 'package:movie/widgets/videoplayeritem.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/credits_model.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/image_model.dart';
import 'package:movie/models/video_list.dart';
import 'package:movie/models/video_model.dart';
import 'package:parallax_image/parallax_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MovieDetailPageState state, Dispatch dispatch, ViewService viewService) {
  Random random = new Random(DateTime.now().millisecondsSinceEpoch);
  var s = state.movieDetailModel;
  //var dominantColor = state.palette?.dominantColor?.color ?? Colors.black38;
  var dominantColor = state.mainColor;
  double evote = 0.0;

  Widget _buildCreditsCell(CastData p) {
    return GestureDetector(
      onTap: () => dispatch(MovieDetailPageActionCreator.onCastCellTapped(
          p.id, p.profilePath, p.name)),
      child: Container(
        margin: EdgeInsets.only(left: Adapt.px(20)),
        width: Adapt.px(240),
        height: Adapt.px(400),
        child: Card(
          shape:
              RoundedRectangleBorder(side: BorderSide(color: Colors.grey[100])),
          elevation: 1.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: 'people' + p.id.toString(),
                child: Container(
                  width: Adapt.px(240),
                  height: Adapt.px(260),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              p.profilePath == null
                                  ? ImageUrl.emptyimage
                                  : ImageUrl.getUrl(
                                      p.profilePath, ImageSize.w300)))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: Adapt.px(20), left: Adapt.px(20), right: Adapt.px(20)),
                child: Hero(
                  tag: 'Actor' + p.id.toString(),
                  child: Material(
                    child: Text(
                      p.name,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Adapt.px(30),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: Adapt.px(20),
                    right: Adapt.px(20),
                    bottom: Adapt.px(20)),
                child: Text(
                  p.character,
                  maxLines: 2,
                  style: TextStyle(color: Colors.black, fontSize: Adapt.px(24)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationCell(VideoListResult d) {
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.only(
            left: Adapt.px(30),
          ),
          width: Adapt.px(400),
          height: Adapt.px(400) * 9 / 16,
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(Adapt.px(10)),
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  width: Adapt.px(400),
                  height: Adapt.px(400) * 9 / 16,
                  placeholder: 'images/CacheBG.jpg',
                  image: ImageUrl.getUrl(
                      d.backdropPath ?? '/eIkFHNlfretLS1spAcIoihKUS62.jpg',
                      ImageSize.w400),
                ),
              ),
              Container(
                padding: EdgeInsets.all(Adapt.px(10)),
                alignment: Alignment.bottomLeft,
                child: Text(
                  d.originalTitle,
                  softWrap: false,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Adapt.px(28),
                      shadows: <Shadow>[
                        Shadow(
                            blurRadius: 1.2,
                            color: Colors.black87,
                            offset: Offset(Adapt.px(2), Adapt.px(2)))
                      ]),
                ),
              ),
              Container(
                padding: EdgeInsets.all(Adapt.px(10)),
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: Adapt.px(28),
                    ),
                    Text(d.voteAverage.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Adapt.px(28),
                            shadows: <Shadow>[
                              Shadow(
                                  blurRadius: 1.2,
                                  color: Colors.black87,
                                  offset: Offset(Adapt.px(3), Adapt.px(3)))
                            ]))
                  ],
                ),
              ),
            ],
          )),
      onTap: () => dispatch(MovieDetailPageActionCreator.onRecommendationTapped(
          d.id, d.backdropPath)),
    );
  }

  Widget _buildVideoCell(VideoResult d) {
    return Container(
      padding: EdgeInsets.fromLTRB(Adapt.px(30), 0, Adapt.px(30), Adapt.px(30)),
      child: Card(
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            VideoPlayerItem(
              vc: VideoPlayerController.network(VideoUrl.getUrl(d.key, d.site)),
              coverurl: 'https://i.ytimg.com/vi/${d.key}/hqdefault.jpg',
              showplayer: true,
            ),
            Padding(
              padding: EdgeInsets.all(Adapt.px(20)),
              child: Text(
                d.name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Adapt.px(35),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreditsShimmerCell() {
    return SizedBox(
      width: Adapt.px(240),
      height: Adapt.px(480),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[100],
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.grey[200],
              width: Adapt.px(240),
              height: Adapt.px(260),
            ),
            Container(
              height: Adapt.px(24),
              margin: EdgeInsets.fromLTRB(0, Adapt.px(15), Adapt.px(20), 0),
              color: Colors.grey[200],
            ),
            Container(
              height: Adapt.px(24),
              margin: EdgeInsets.fromLTRB(0, Adapt.px(5), Adapt.px(20), 0),
              color: Colors.grey[200],
            ),
            Container(
              height: Adapt.px(24),
              margin: EdgeInsets.fromLTRB(
                  0, Adapt.px(5), Adapt.px(70), Adapt.px(20)),
              color: Colors.grey[200],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCell(ImageData d) {
    double w = (Adapt.screenW() - Adapt.px(100)) / 2;
    double h = w / d.aspectRatio;
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: Color.fromRGBO(random.nextInt(255), random.nextInt(255),
            random.nextInt(255), random.nextDouble()),
      ),
      child: ParallaxImage(
          extent: h,
          image: CachedNetworkImageProvider(
              ImageUrl.getUrl(d.filePath, ImageSize.w300))),
    );
  }

  Widget _buildShimmerVideoCell() {
    return Container(
      padding: EdgeInsets.fromLTRB(Adapt.px(30), 0, Adapt.px(30), Adapt.px(30)),
      child: Shimmer.fromColors(
        highlightColor: Colors.grey[100],
        baseColor: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: Adapt.px(10),
            ),
            Container(
              height: (Adapt.screenW() - Adapt.px(60)) * 9 / 16,
              color: Colors.grey[200],
            ),
            SizedBox(
              height: Adapt.px(20),
            ),
            Container(
              height: Adapt.px(35),
              color: Colors.grey[200],
            ),
            SizedBox(
              height: Adapt.px(8),
            ),
            Container(
              margin: EdgeInsets.only(right: Adapt.px(200)),
              height: Adapt.px(35),
              color: Colors.grey[200],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationShimmer() {
    return SizedBox(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[100],
        child: Container(
          width: Adapt.px(400),
          height: Adapt.px(400) * 9 / 16,
          margin: EdgeInsets.only(left: Adapt.px(30)),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(Adapt.px(10)),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildRecommendationBody() {
    if (state.movieDetailModel?.recommendations != null)
      return state.movieDetailModel.recommendations.results
          .map(_buildRecommendationCell)
          .toList();
    else
      return <Widget>[
        _buildRecommendationShimmer(),
        _buildRecommendationShimmer(),
        _buildRecommendationShimmer(),
      ];
  }

  Widget _getVideoBody() {
    if (state.videomodel.results.length > 0)
      return SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext contxt, int index) {
        return _buildVideoCell(state.videomodel.results[index]);
      }, childCount: state.videomodel.results.length));
    else
      return SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext contxt, int index) {
        return _buildShimmerVideoCell();
      }, childCount: 3));
  }

  Widget _getImageBody() {
    var hset = new HashSet<ImageData>()
      ..addAll(state.imagesmodel.backdrops)
      ..addAll(state.imagesmodel.posters);
    var allimage = hset.toList();
    if (allimage.length > 0)
      return SliverStaggeredGrid.countBuilder(
        crossAxisCount: 4,
        staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
        mainAxisSpacing: Adapt.px(20),
        crossAxisSpacing: Adapt.px(20),
        itemCount: allimage.length,
        itemBuilder: (BuildContext contxt, int index) {
          return _buildImageCell(allimage[index]);
        },
      );
    /*return SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext contxt, int index) {
        return _buildImageCell(allimage[index]);
      }, childCount: allimage.length));*/
    else
      return SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext contxt, int index) {
        return _buildShimmerVideoCell();
      }, childCount: 3));
  }

  Widget _getPosterPic() {
    if (state.posterPic == null)
      return SizedBox(
          child: Shimmer.fromColors(
        baseColor: Colors.grey[500],
        highlightColor: Colors.grey[100],
        child: Container(
          height: Adapt.px(300),
          width: Adapt.px(200),
          color: Colors.grey[500],
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

  Widget _getTitle() {
    if (state.title == null)
      return SizedBox(
          child: Shimmer.fromColors(
        baseColor: Colors.grey[500],
        highlightColor: Colors.grey[100],
        child: Container(
          height: Adapt.px(50),
          width: Adapt.px(200),
          color: Colors.grey[500],
        ),
      ));
    else
      return RichText(
        text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: state.title ?? '',
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
              text: s.title == null
                  ? ' (-)'
                  : ' (${DateTime.tryParse(s.releaseDate)?.year.toString()})',
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

  Widget _getOverWatch() {
    if (state.movieDetailModel.overview == null)
      return SizedBox(
          child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[100],
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: Adapt.px(60)),
                color: Colors.grey[200],
                height: Adapt.px(30),
              ),
              SizedBox(
                height: Adapt.px(10),
              ),
              Container(
                color: Colors.grey[200],
                height: Adapt.px(30),
              ),
              SizedBox(
                height: Adapt.px(10),
              ),
              Container(
                color: Colors.grey[200],
                height: Adapt.px(30),
              ),
              SizedBox(
                height: Adapt.px(10),
              ),
              Container(
                color: Colors.grey[200],
                height: Adapt.px(30),
              ),
              SizedBox(
                height: Adapt.px(10),
              ),
              Container(
                color: Colors.grey[200],
                height: Adapt.px(30),
              ),
              SizedBox(
                height: Adapt.px(10),
              ),
              Container(
                color: Colors.grey[200],
                height: Adapt.px(30),
              ),
              SizedBox(
                height: Adapt.px(10),
              ),
              Container(
                color: Colors.grey[200],
                height: Adapt.px(30),
              ),
            ],
          ),
        ),
      ));
    else
      return Text(s.overview,
          style: TextStyle(
              color: Colors.black,
              fontSize: Adapt.px(30),
              height: 1.2,
              fontWeight: FontWeight.w400));
  }

  Widget _getCreditsCells() {
    if (state.movieDetailModel?.credits != null)
      return ListView(
        scrollDirection: Axis.horizontal,
        children:
            state.movieDetailModel.credits.cast.map(_buildCreditsCell).toList(),
      );
    else
      return ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SizedBox(
            width: Adapt.px(30),
          ),
          _buildCreditsShimmerCell(),
          SizedBox(
            width: Adapt.px(30),
          ),
          _buildCreditsShimmerCell(),
          SizedBox(
            width: Adapt.px(30),
          ),
          _buildCreditsShimmerCell(),
        ],
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
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.play_arrow, color: Colors.white),
                      Text(I18n.of(viewService.context).playTrailer,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: Adapt.px(30),
                              color: Colors.white))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  return Scaffold(
    key: state.scaffoldkey,
    body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
            controller: state.scrollController,
            headerSliverBuilder: (BuildContext context, bool de) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                      pinned: true,
                      /*backgroundColor: state.palette.darkVibrantColor?.color ??
                          Colors.black87,*/
                      backgroundColor: dominantColor,
                      expandedHeight: Adapt.px(700),
                      centerTitle: false,
                      title: Text(de ? state.title ?? '' : ''),
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(Icons.more_vert),
                          color: Colors.white,
                          iconSize: Adapt.px(50),
                          onPressed: () =>
                              dispatch(MovieDetailPageActionCreator.openMenu()),
                        )
                      ],
                      bottom: PreferredSize(
                        preferredSize: new Size(double.infinity, Adapt.px(60)),
                        child: Container(
                            width: Adapt.screenW(),
                            color: Colors.white,
                            child: TabBar(
                              labelColor: Colors.black,
                              /*indicatorColor:
                                  state.palette.lightVibrantColor?.color ??
                                      Colors.black,*/
                              indicatorColor: state.tabTintColor,
                              indicatorSize: TabBarIndicatorSize.label,
                              isScrollable: true,
                              labelStyle: TextStyle(
                                  fontSize: Adapt.px(35),
                                  fontWeight: FontWeight.w600),
                              tabs: <Widget>[
                                Tab(text: I18n.of(viewService.context).main),
                                Tab(text: I18n.of(viewService.context).videos),
                                Tab(text: I18n.of(viewService.context).images),
                                Tab(text: I18n.of(viewService.context).reviews),
                              ],
                            )),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: false,
                        background: _buildHeader(),
                      )),
                )
              ];
            },
            body: TabBarView(
              children: <Widget>[
                Container(child: Builder(builder: (BuildContext context) {
                  return CustomScrollView(slivers: <Widget>[
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            Adapt.px(30), Adapt.px(30), Adapt.px(30), 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(I18n.of(viewService.context).overView,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Adapt.px(40),
                                    fontWeight: FontWeight.w800)),
                            SizedBox(
                              height: Adapt.px(30),
                            ),
                            _getOverWatch(),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: AnimatedSwitcher(
                            switchInCurve: Curves.easeIn,
                            switchOutCurve: Curves.easeOut,
                            duration: Duration(milliseconds: 600),
                            child: Column(
                              key: ValueKey(state.movieDetailModel.id),
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(Adapt.px(30)),
                                  child: Text(
                                      I18n.of(viewService.context)
                                          .topBilledCast,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Adapt.px(40),
                                          fontWeight: FontWeight.w800)),
                                ),
                                Container(
                                  height: Adapt.px(450),
                                  child: _getCreditsCells(),
                                ),
                              ],
                            ))),
                    SliverToBoxAdapter(
                      child: viewService.buildComponent('keywords'),
                    ),
                    SliverToBoxAdapter(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(Adapt.px(30)),
                          child: Text(
                              I18n.of(viewService.context).recommendations,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Adapt.px(40),
                                  fontWeight: FontWeight.w800)),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: Adapt.px(30)),
                          height: Adapt.px(400) * 9 / 16,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: _buildRecommendationBody(),
                          ),
                        ),
                      ],
                    )),
                    SliverToBoxAdapter(
                      child: viewService.buildComponent('info'),
                    ),
                  ]);
                })),
                Container(child: Builder(builder: (BuildContext context) {
                  return CustomScrollView(slivers: <Widget>[
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                    ),
                    _getVideoBody()
                  ]);
                })),
                Container(child: Builder(builder: (BuildContext context) {
                  return CustomScrollView(slivers: <Widget>[
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                    ),
                    _getImageBody()
                  ]);
                })),
                Container(child: Builder(builder: (BuildContext context) {
                  return CustomScrollView(slivers: <Widget>[
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext contxt, int index) {
                        return GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                Adapt.px(30), 0, Adapt.px(30), Adapt.px(30)),
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.all(Adapt.px(30)),
                                height: 300,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'A Review by ${state.reviewModel.results[index].author}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Adapt.px(30),
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: Adapt.px(20),
                                    ),
                                    new Expanded(
                                      child: new LayoutBuilder(builder:
                                          (BuildContext context,
                                              BoxConstraints constraints) {
                                        print(constraints);
                                        return new Text(
                                          state.reviewModel.results[index]
                                              .content,
                                          overflow: TextOverflow.fade,
                                          maxLines: (constraints.maxHeight /
                                                  Theme.of(context)
                                                      .textTheme
                                                      .bodyText1
                                                      .fontSize)
                                              .floor(),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onTap: () async {
                            var url = state.reviewModel.results[index].url;
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                          },
                        );
                      }, childCount: state.reviewModel.results.length),
                    ),
                  ]);
                })),
              ],
            ))),
  );
}
