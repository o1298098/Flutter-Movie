import 'dart:collection';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/actions/videourl.dart';
import 'package:movie/actions/votecolorhelper.dart';
import 'package:movie/customwidgets/videoplayeritem.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/creditsmodel.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/videolist.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    TVDetailPageState state, Dispatch dispatch, ViewService viewService) {
  final s = state.tvDetailModel;
  //var dominantColor = state.palette?.dominantColor?.color ?? Colors.black38;
  final dominantColor = state.mainColor;

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
                  d.name ?? '',
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
      onTap: () => dispatch(TVDetailPageActionCreator.onRecommendationTapped(
          d.id, d.backdropPath)),
    );
  }

  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);

    Widget _buildCreditsShimmerCell() {
      return SizedBox(
        width: Adapt.px(240),
        height: Adapt.px(480),
        child: Shimmer.fromColors(
          baseColor: _theme.primaryColorDark,
          highlightColor: _theme.primaryColorLight,
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

    Widget _buildCreditsCell(CastData p) {
      return GestureDetector(
        onTap: () => dispatch(TVDetailPageActionCreator.onCastCellTapped(
            p.id, p.profilePath, p.name)),
        child: Container(
          margin: EdgeInsets.only(left: Adapt.px(20)),
          width: Adapt.px(240),
          height: Adapt.px(400),
          child: Card(
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
                        color: _theme.primaryColorLight,
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
                      top: Adapt.px(20),
                      left: Adapt.px(20),
                      right: Adapt.px(20)),
                  child: Hero(
                    tag: 'Actor' + p.id.toString(),
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        p.name,
                        maxLines: 2,
                        style: TextStyle(
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
                    style:
                        TextStyle(color: Colors.grey, fontSize: Adapt.px(24)),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget _getCreditsCells() {
      if (state.tvDetailModel.credits != null)
        return ListView(
          scrollDirection: Axis.horizontal,
          children:
              state.tvDetailModel.credits.cast.map(_buildCreditsCell).toList(),
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

    Widget _buildRecommendationShimmer() {
      return SizedBox(
        child: Shimmer.fromColors(
          baseColor: _theme.primaryColorDark,
          highlightColor: _theme.primaryColorLight,
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
      if (state.tvDetailModel.recommendations != null &&
          state.tvDetailModel.recommendations.results.length > 0)
        return state.tvDetailModel.recommendations.results
            .map(_buildRecommendationCell)
            .toList();
      else
        return <Widget>[
          _buildRecommendationShimmer(),
          _buildRecommendationShimmer(),
          _buildRecommendationShimmer(),
        ];
    }

    return Scaffold(
        key: state.scaffoldkey,
        body: DefaultTabController(
            length: 4,
            child: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool de) {
                  return <Widget>[
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverAppBar(
                          pinned: true,
                          backgroundColor: dominantColor,
                          expandedHeight: Adapt.px(700),
                          centerTitle: false,
                          title: Text(de ? s.name ?? '' : ''),
                          actions: <Widget>[
                            IconButton(
                              icon: Icon(Icons.more_vert),
                              color: Colors.white,
                              iconSize: Adapt.px(50),
                              onPressed: () => dispatch(
                                  TVDetailPageActionCreator.openMenu()),
                            )
                          ],
                          bottom: PreferredSize(
                            preferredSize:
                                new Size(double.infinity, Adapt.px(60)),
                            child: Container(
                                width: Adapt.screenW(),
                                color: _theme.backgroundColor,
                                child: TabBar(
                                  labelColor: _theme.tabBarTheme.labelColor,
                                  indicatorColor: state.tabTintColor,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  isScrollable: true,
                                  labelStyle: TextStyle(
                                      fontSize: Adapt.px(35),
                                      fontWeight: FontWeight.w600),
                                  tabs: <Widget>[
                                    Tab(
                                        text:
                                            I18n.of(viewService.context).main),
                                    Tab(
                                        text: I18n.of(viewService.context)
                                            .videos),
                                    Tab(
                                        text: I18n.of(viewService.context)
                                            .images),
                                    Tab(
                                        text: I18n.of(viewService.context)
                                            .reviews),
                                  ],
                                )),
                          ),
                          flexibleSpace: FlexibleSpaceBar(
                            centerTitle: false,
                            background: viewService.buildComponent('header'),
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
                        viewService.buildComponent('tvInfo'),
                        SliverToBoxAdapter(
                            child: AnimatedSwitcher(
                          switchInCurve: Curves.easeIn,
                          switchOutCurve: Curves.easeOut,
                          duration: Duration(milliseconds: 600),
                          child: Column(
                            key: ValueKey(state.tvDetailModel.id),
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(Adapt.px(30)),
                                child: Text(
                                    I18n.of(viewService.context).topBilledCast,
                                    style: TextStyle(
                                        fontSize: Adapt.px(40),
                                        fontWeight: FontWeight.w800)),
                              ),
                              Container(
                                height: Adapt.px(450),
                                child: _getCreditsCells(),
                              ),
                            ],
                          ),
                        )),
                        viewService.buildComponent('currentSeason'),
                        viewService.buildComponent('keywords'),
                        SliverToBoxAdapter(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(Adapt.px(30)),
                              child: Text(
                                  I18n.of(viewService.context).recommendations,
                                  style: TextStyle(
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
                        viewService.buildComponent('info'),
                      ]);
                    })),
                    viewService.buildComponent('videos'),
                    viewService.buildComponent('images'),
                    viewService.buildComponent('reviews'),
                  ],
                ))));
  });
}
