import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/season_detail.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SeasonsPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Scaffold(
      appBar: AppBar(
        brightness: _theme.brightness,
        backgroundColor: _theme.backgroundColor,
        iconTheme: _theme.iconTheme,
        title: Text(
          'All Seasons',
          style: _theme.textTheme.bodyText1,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(20)),
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: Adapt.px(20)),
          itemCount: state.seasons.length,
          itemBuilder: (ctx, index) {
            return _Cell(
              index: index,
              season: state.seasons[index],
              length: state.seasons.length,
              controller: state.animationController,
              onTap: (d) => dispatch(SeasonsPageActionCreator.onCellTapped(
                  state.tvid, d.seasonNumber, d.name, d.posterPath)),
            );
          },
        ),
      ),
    );
  });
}

class _Cell extends StatelessWidget {
  final int index;
  final int length;
  final Season season;
  final Function(Season) onTap;
  final AnimationController controller;
  const _Cell(
      {this.index, this.length, this.season, this.controller, this.onTap});
  @override
  Widget build(BuildContext context) {
    final Random random = Random(DateTime.now().millisecondsSinceEpoch);
    final curve = CurvedAnimation(
      parent: controller,
      curve: Interval(
        index * (1.0 / length),
        (index + 1) * (1.0 / length),
        curve: Curves.ease,
      ),
    );
    return SlideTransition(
      position: Tween(begin: Offset(0, 1), end: Offset.zero).animate(curve),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curve),
        child: GestureDetector(
          onTap: () => onTap(season),
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: Adapt.px(225),
                  height: Adapt.px(380),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(
                        random.nextInt(255),
                        random.nextInt(255),
                        random.nextInt(255),
                        random.nextDouble()),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        season.posterPath == null
                            ? ImageUrl.emptyimage
                            : ImageUrl.getUrl(
                                season.posterPath, ImageSize.w300),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Adapt.px(20),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: Adapt.px(20),
                    ),
                    Container(
                      width: Adapt.screenW() - Adapt.px(320),
                      child: Text(
                        season.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Adapt.px(30)),
                      ),
                    ),
                    SizedBox(
                      height: Adapt.px(5),
                    ),
                    Text('Air Date: ${season.airDate}'),
                    SizedBox(
                      height: Adapt.px(5),
                    ),
                    Text('Episode Count: ${season.episodeCount}'),
                    SizedBox(
                      height: Adapt.px(10),
                    ),
                    Container(
                      width: Adapt.screenW() - Adapt.px(320),
                      child: Text(
                        season.overview == null || season.overview == ''
                            ? 'No overview have been added'
                            : season.overview,
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                        //style: TextStyle(height: 1.2),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
