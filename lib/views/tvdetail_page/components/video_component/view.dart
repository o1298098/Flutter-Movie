import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/videourl.dart';
import 'package:movie/customwidgets/videoplayeritem.dart';
import 'package:movie/models/videomodel.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(VideoState state, Dispatch dispatch, ViewService viewService) {
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
                    fontSize: Adapt.px(35), fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
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

  Widget _getVideoBody() {
    if (state.videos.length > 0)
      return SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext contxt, int index) {
        return _buildVideoCell(state.videos[index]);
      }, childCount: state.videos.length));
    else
      return SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext contxt, int index) {
        return _buildShimmerVideoCell();
      }, childCount: 3));
  }

  return Container(child: Builder(builder: (BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverOverlapInjector(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      ),
      _getVideoBody()
    ]);
  }));
}
