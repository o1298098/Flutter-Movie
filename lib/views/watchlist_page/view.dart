import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/customwidgets/hero_dialog_route.dart';
import 'package:movie/customwidgets/watchlistdetail.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/videolist.dart';
import 'dart:math' as math;

import 'action.dart';
import 'state.dart';

Widget buildView(
    WatchlistPageState state, Dispatch dispatch, ViewService viewService) {
  void _cellTapped(VideoListResult d) async {
    int index = state.tvshowList.results.indexOf(d);
    await Navigator.of(viewService.context, rootNavigator: true).push(
        PageRouteBuilder(
            opaque: false,
            barrierDismissible: true,
            barrierColor: Colors.black45,
            transitionDuration: Duration(milliseconds: 300),
            pageBuilder: (BuildContext context, Animation animation,
                Animation secondaryAnimation) {
              return SlideTransition(
                position: Tween(begin: Offset(0, 1), end: Offset(0, 0.2))
                    .animate(
                        CurvedAnimation(parent: animation, curve: Curves.ease)),
                child: WatchlistDetail(
                  initialIndex: index,
                  data: state.tvshowList,
                ),
              );
            }));
  }

  Widget _buildGirdCell(VideoListResult d) {
    return GestureDetector(
      onTap: () => _cellTapped(d),
      child: Hero(
        tag: 'background${d.id}',
        child: Material(
          child: Container(
            decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(Adapt.px(30)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                        ImageUrl.getUrl(d.poster_path, ImageSize.w300)))),
          ),
        ),
      ),
    );
  }

  Widget _buildListCell(VideoListResult d) {
    return Container(
      color: Colors.grey[200],
      child: Row(
        children: <Widget>[
          Container(
            width: Adapt.screenW() / (1.6 * 1.6),
            decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(Adapt.px(30)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                        ImageUrl.getUrl(d.poster_path, ImageSize.w300)))),
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    return AnimatedSwitcher(
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      duration: Duration(milliseconds: 300),
      child: state.tvshowList == null
          ? Container()
          : CustomScrollView(
              key: ValueKey('Gird${state.isList}'),
              slivers: <Widget>[
                SliverGrid.extent(
                  mainAxisSpacing: Adapt.px(10),
                  crossAxisSpacing: Adapt.px(10),
                  maxCrossAxisExtent:
                      state.isList ? Adapt.screenW() : Adapt.screenW() / 3,
                  childAspectRatio: state.isList ? 1.6 : (1 / 1.6),
                  children: state.tvshowList.results
                      .map(state.isList ? _buildListCell : _buildGirdCell)
                      .toList(),
                )
              ],
            ),
    );
  }

  return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          IconButton(
            icon: Icon(state.isList ? Icons.apps : Icons.format_list_bulleted),
            onPressed: () {
              dispatch(WatchlistPageActionCreator.widthChanged(!state.isList));
            },
          )
        ],
      ),
      body: _buildBody());
}
