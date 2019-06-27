import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/actions/videourl.dart';
import 'package:movie/actions/votecolorhelper.dart';
import 'package:movie/customwidgets/videoplayeritem.dart';
import 'package:movie/models/creditsmodel.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:movie/models/videolist.dart';
import 'package:movie/models/videomodel.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MovieDetailPageState state, Dispatch dispatch, ViewService viewService) {
  var s = state.movieDetailModel;
  var dominantColor = state.palette?.dominantColor?.color ?? Colors.black38;
  double evote = 0.0;

  Widget _buildCreditsCell(CastData p) {
    return GestureDetector(
      onTap: () => dispatch(MovieDetailPageActionCreator.onCastCellTapped(
          p.id, p.profile_path, p.name)),
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
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  width: Adapt.px(240),
                  height: Adapt.px(260),
                  placeholder: 'images/CacheBG.jpg',
                  image: ImageUrl.getUrl(
                      p.profile_path ?? '/eIkFHNlfretLS1spAcIoihKUS62.jpg',
                      ImageSize.w300),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: Adapt.px(20), left: Adapt.px(20), right: Adapt.px(20)),
                child: Hero(
                  tag: 'Actor' + p.id.toString(),
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
                      d.backdrop_path ?? '/eIkFHNlfretLS1spAcIoihKUS62.jpg',
                      ImageSize.w400),
                ),
              ),
              Container(
                padding: EdgeInsets.all(Adapt.px(10)),
                alignment: Alignment.bottomLeft,
                child: Text(
                  d.original_title,
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
                    Text(d.vote_average.toString(),
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
      onTap: () =>
          dispatch(MovieDetailPageActionCreator.onRecommendationTapped(d.id,d.backdrop_path)),
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
              margin: EdgeInsets.fromLTRB(0,Adapt.px(15),Adapt.px(20),0),
              color: Colors.grey[200],
            ),
            Container(
              height: Adapt.px(24),
              margin: EdgeInsets.fromLTRB(0,Adapt.px(5),Adapt.px(20),0),
              color: Colors.grey[200],
            ),
            Container(
              height: Adapt.px(24),
              margin: EdgeInsets.fromLTRB(0,Adapt.px(5),Adapt.px(70),Adapt.px(20)),
              color: Colors.grey[200],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCell(ImageData d) {
    return Container(
      padding: EdgeInsets.fromLTRB(Adapt.px(30), 0, Adapt.px(30), Adapt.px(20)),
      child: Card(
        elevation: 1.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FadeInImage.assetNetwork(
              placeholder: 'images/CacheBG.jpg',
              image: ImageUrl.getUrl(d.file_path, ImageSize.w400),
            ),
            Padding(
              padding: EdgeInsets.only(left: Adapt.px(30), right: Adapt.px(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Size:${d.width}x${d.height}',
                    style:
                        TextStyle(color: Colors.black, fontSize: Adapt.px(30)),
                  ),
                  IconButton(
                    icon: Icon(Icons.cloud_download),
                    onPressed: () {},
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationShimmer(){
    return SizedBox(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[100],
        child: Container(
          width: Adapt.px(400),
          height: Adapt.px(400) * 9 / 16,
          margin: EdgeInsets.only(left:Adapt.px(30)),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(Adapt.px(10)),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildRecommendationBody(){
    if(state.recommendations.results.length>0)
    return state.recommendations.results.map(_buildRecommendationCell).toList();
    else
    return <Widget>[
      _buildRecommendationShimmer(),
      _buildRecommendationShimmer(),
      _buildRecommendationShimmer(),
    ];
  }

  Widget _getPosterPic() {
    if (state.movieDetailModel.poster_path == null)
      return SizedBox(
          child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[100],
        child: Container(
          height: Adapt.px(300),
          width: Adapt.px(200),
          color: Colors.grey[200],
        ),
      ));
    else
      return Card(
        elevation: 20.0,
        child: Image.network(
          ImageUrl.getUrl(state.movieDetailModel.poster_path, ImageSize.w500),
          height: Adapt.px(300),
          width: Adapt.px(200),
          fit: BoxFit.cover,
        ),
      );
  }

  Widget _getTitle() {
    if (state.movieDetailModel.title == null)
      return SizedBox(
          child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[100],
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
              text: s.title,
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
              text: ' (${DateTime.tryParse(s.release_date).year.toString()})',
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
              fontWeight: FontWeight.w400));
  }

  Widget _getCreditsCells() {
    if (state.creditsModel.cast.length > 0)
      return ListView(
        scrollDirection: Axis.horizontal,
        children: state.creditsModel.cast.map(_buildCreditsCell).toList(),
      );
    else
     return ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SizedBox(width: Adapt.px(30),),
          _buildCreditsShimmerCell(),
          SizedBox(width: Adapt.px(30),),
          _buildCreditsShimmerCell(),
          SizedBox(width: Adapt.px(30),),
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
              child: SizedBox.expand(
                child: FadeInImage.assetNetwork(
                  placeholder: 'images/CacheBG.jpg',
                  image: ImageUrl.getUrl(state.backdropPic, ImageSize.w500),
                  fit: BoxFit.cover,
                ),
              )),
          Container(
            width: Adapt.screenW(),
            height: Adapt.px(401),
            color: dominantColor.withOpacity(.9),
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
                      Stack(
                        children: <Widget>[
                          Container(
                              width: Adapt.px(80),
                              height: Adapt.px(80),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Adapt.px(40))),
                              child: CircularProgressIndicator(
                                strokeWidth: 6.0,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    VoteColorHelper.getColor(
                                        s.vote_average ?? evote)),
                                backgroundColor: Colors.grey,
                                value: (s.vote_average ?? evote) / 10,
                              )),
                          Container(
                              width: Adapt.px(80),
                              height: Adapt.px(80),
                              child: Center(
                                child: Text(
                                  ((s.vote_average ?? evote) * 10)
                                          .floor()
                                          .toString() +
                                      '%',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: Adapt.px(28),
                                      color: Colors.white),
                                ),
                              ))
                        ],
                      ),
                      SizedBox(
                        width: Adapt.px(30),
                      ),
                      Text('User Score',
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
                      Text('Play Traller',
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
    body: Scaffold(
        body: DefaultTabController(
            length: 4,
            child: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool de) {
                  return <Widget>[
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      child: SliverAppBar(
                          pinned: true,
                          backgroundColor:
                              state.palette.darkVibrantColor?.color ??
                                  Colors.black87,
                          expandedHeight: Adapt.px(700),
                          centerTitle: false,
                          title: Text(de ? s.original_title??'' : ''),
                          actions: <Widget>[
                            IconButton(
                              icon: Icon(Icons.more_vert),
                              color: Colors.white,
                              iconSize: Adapt.px(50),
                              onPressed: () {},
                            )
                          ],
                          bottom: PreferredSize(
                            preferredSize:
                                new Size(double.infinity, Adapt.px(60)),
                            child: Container(
                                width: Adapt.screenW(),
                                color: Colors.white,
                                child: TabBar(
                                  labelColor: Colors.black,
                                  indicatorColor:
                                      state.palette.lightVibrantColor?.color ??
                                          Colors.black,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  isScrollable: true,
                                  labelStyle: TextStyle(
                                      fontSize: Adapt.px(35),
                                      fontWeight: FontWeight.w600),
                                  tabs: <Widget>[
                                    Tab(text: 'Main'),
                                    Tab(text: 'Videos'),
                                    Tab(text: 'Images'),
                                    Tab(text: 'Reviews'),
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
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                Adapt.px(30), Adapt.px(30), Adapt.px(30), 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('OverView',
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
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(Adapt.px(30)),
                              child: Text('Top Billed Cast',
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
                        )),
                        SliverToBoxAdapter(
                          child: viewService.buildComponent('keywords'),
                        ),
                        SliverToBoxAdapter(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(Adapt.px(30)),
                              child: Text('Recommendations',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Adapt.px(40),
                                      fontWeight: FontWeight.w800)),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: Adapt.px(70)),
                              height: Adapt.px(400) * 9 / 16,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: _buildRecommendationBody(),
                              ),
                            ),
                          ],
                        ))
                      ]);
                    })),
                    Container(child: Builder(builder: (BuildContext context) {
                      return CustomScrollView(slivers: <Widget>[
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext contxt, int index) {
                          return _buildVideoCell(
                              state.videomodel.results[index]);
                        }, childCount: state.videomodel.results.length))
                      ]);
                    })),
                    Container(child: Builder(builder: (BuildContext context) {
                      var allimage = new List<ImageData>()
                        ..addAll(state.imagesmodel.backdrops)
                        ..addAll(state.imagesmodel.posters);
                      return CustomScrollView(slivers: <Widget>[
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext contxt, int index) {
                          return _buildImageCell(allimage[index]);
                        }, childCount: allimage.length))
                      ]);
                    })),
                    Container(child: Builder(builder: (BuildContext context) {
                      return CustomScrollView(slivers: <Widget>[
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext contxt, int index) {
                            return GestureDetector(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(Adapt.px(30), 0,
                                    Adapt.px(30), Adapt.px(30)),
                                child: Card(
                                  child: Container(
                                    padding: EdgeInsets.all(Adapt.px(30)),
                                    height: 300,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                          .body1
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
                )))),
  );
}
