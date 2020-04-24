import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/videourl.dart';
import 'package:movie/customwidgets/videoplayeritem.dart';
import 'package:movie/models/videomodel.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

import 'state.dart';

Widget buildView(VideoState state, Dispatch dispatch, ViewService viewService) {
  return Container(child: Builder(builder: (BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverOverlapInjector(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      ),
      _VideoBody(videos: state.videos ?? [])
    ]);
  }));
}

class _ShimmerVideoCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Container(
      padding: EdgeInsets.fromLTRB(Adapt.px(30), 0, Adapt.px(30), Adapt.px(30)),
      child: Shimmer.fromColors(
        highlightColor: _theme.primaryColorDark,
        baseColor: _theme.primaryColorLight,
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
}

class _VideoCell extends StatefulWidget {
  final VideoResult d;
  const _VideoCell({this.d});
  @override
  _VideoCellState createState() => _VideoCellState();
}

class _VideoCellState extends State<_VideoCell> {
  VideoPlayerController _controller;
  @override
  void initState() {
    _controller = VideoPlayerController.network(
        VideoUrl.getUrl(widget.d.key, widget.d.site));
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(Adapt.px(30), 0, Adapt.px(30), Adapt.px(30)),
      child: Card(
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            VideoPlayerItem(
              vc: _controller,
              coverurl: 'https://i.ytimg.com/vi/${widget.d.key}/hqdefault.jpg',
              showplayer: true,
            ),
            Padding(
              padding: EdgeInsets.all(Adapt.px(20)),
              child: Text(
                widget.d.name,
                style: TextStyle(
                    fontSize: Adapt.px(35), fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VideoBody extends StatelessWidget {
  final List<VideoResult> videos;
  const _VideoBody({this.videos});
  @override
  Widget build(BuildContext context) {
    if (videos.length > 0)
      return SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext contxt, int index) {
        return _VideoCell(d: videos[index]);
      }, childCount: videos.length));
    else
      return SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext contxt, int index) {
        return _ShimmerVideoCell();
      }, childCount: 3));
  }
}
