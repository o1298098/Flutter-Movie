import 'package:chewie/chewie.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/customwidgets/sliverappbar_delegate.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(TvShowLiveStreamPageState state, Dispatch dispatch,
    ViewService viewService) {
  Widget _getPlayer() {
    double _height = Adapt.screenW() * 9 / 16;
    String key = state.streamLinkType?.name ?? '';
    switch (key) {
      case 'YouTube':
        return YoutubePlayer(
          controller: state.youtubePlayerController,
          topActions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: Adapt.px(80),
              ),
              onPressed: () => Navigator.of(viewService.context).pop(),
            )
          ],
          progressIndicatorColor: Colors.red,
          progressColors: ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
        );
      case 'WebView':
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: WebView(
            key: ValueKey(state.streamAddress),
            initialUrl: state.streamAddress,
            javascriptMode: JavascriptMode.unrestricted,
          ),
        );
      case 'other':
        return Container(
          color: Colors.black,
          alignment: Alignment.bottomCenter,
          height: _height,
          child: state.chewieController != null
              ? Chewie(
                  key: ValueKey(state.chewieController),
                  controller: state.chewieController)
              : SizedBox(),
        );
      default:
        return Container(
          height: _height,
          color: Colors.black,
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () => Navigator.of(viewService.context).pop(),
          ),
        );
    }
  }

  Widget _buildVideoPlayer() {
    double _height = Adapt.screenW() * 9 / 16;
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
          maxHeight: _height + Adapt.padTopH(),
          minHeight: _height + Adapt.padTopH(),
          child: Container(
            color: Colors.black,
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.black,
                  height: Adapt.padTopH(),
                ),
                _getPlayer()
              ],
            ),
          )),
    );
  }

  Widget _buildHeader() {
    return SliverToBoxAdapter(
        key: ValueKey('HeaderInfo'),
        child: Container(
          padding: EdgeInsets.all(Adapt.px(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  'no title',
                  style: TextStyle(
                      fontSize: Adapt.px(50), fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: Adapt.px(20)),
              Row(
                children: <Widget>[
                  Text('2019-12-01'),
                  SizedBox(width: Adapt.px(20)),
                  RatingBarIndicator(
                    itemSize: Adapt.px(30),
                    itemPadding: EdgeInsets.symmetric(horizontal: Adapt.px(2)),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    unratedColor: Colors.grey,
                    rating: (9 ?? 0) / 2,
                  ),
                  SizedBox(width: Adapt.px(8)),
                  Text('${9}   (${3000})')
                ],
              )
            ],
          ),
        ));
  }

  Widget _buildStreamLinkCell(TvShowStreamLink d) {
    return InkWell(
        onTap: () => dispatch(
            TvShowLiveStreamPageActionCreator.episodeCellTapped(d.episode)),
        child: Container(
          margin: EdgeInsets.only(left: Adapt.px(30)),
          padding: EdgeInsets.all(Adapt.px(20)),
          width: Adapt.px(300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Adapt.px(20)),
            border: Border.all(
                color: d.episode == state.selectedEpisode
                    ? Colors.blueAccent
                    : Color(0xFF505050)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Episode ${d.episode}'),
              SizedBox(height: Adapt.px(15)),
              Text(
                '${d.linkName}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey, fontSize: Adapt.px(30)),
              ),
            ],
          ),
        ));
  }

  Widget _buildStreamLinkList() {
    return SliverToBoxAdapter(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
          child: Text.rich(TextSpan(children: <TextSpan>[
            TextSpan(
              text: 'Episodes',
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: Adapt.px(30)),
            ),
            TextSpan(
              text: ' ${state.streamLinks?.list?.length ?? ''}',
              style: TextStyle(fontSize: Adapt.px(28), color: Colors.grey),
            )
          ])),
        ),
        SizedBox(height: Adapt.px(30)),
        SizedBox(
          height: Adapt.px(130),
          child: ListView(
              controller: state.episodelistController,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: state.streamLinks?.list
                      ?.map(_buildStreamLinkCell)
                      ?.toList() ??
                  []),
        )
      ],
    ));
  }

  return Scaffold(
    body: CustomScrollView(
      slivers: <Widget>[
        _buildVideoPlayer(),
        _buildHeader(),
        _buildStreamLinkList(),
      ],
    ),
  );
}
