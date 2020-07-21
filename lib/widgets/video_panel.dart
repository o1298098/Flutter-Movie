import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/widgets/web_torrent_player.dart';
import 'package:movie/widgets/webview_player.dart';
import 'package:movie/widgets/youtube_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import 'custom_video_controls.dart';

class PlayerPanel extends StatefulWidget {
  final String streamLink;
  final String background;
  final String playerType;
  final bool streamInBrowser;
  final bool loading;
  final int linkId;
  const PlayerPanel(
      {this.streamLink,
      this.playerType,
      this.background,
      this.linkId,
      this.loading = false,
      this.streamInBrowser = false});
  @override
  _PlayerPanelState createState() => _PlayerPanelState();
}

class _PlayerPanelState extends State<PlayerPanel>
    with AutomaticKeepAliveClientMixin {
  bool _play = false;

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(PlayerPanel oldWidget) {
    if (oldWidget.streamLink != widget.streamLink ||
        oldWidget.playerType != widget.playerType ||
        oldWidget.linkId != widget.linkId ||
        oldWidget.background != widget.background) {
      setState(() {
        _play = false;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  _playTapped() async {
    if (widget.loading) return;
    if (widget.streamInBrowser &&
        (widget.playerType == 'WebView' ||
            widget.playerType == 'VideoSourceApi')) {
      await launch(
        widget.streamLink,
        enableJavaScript: true,
      );
    } else
      setState(() {
        _play = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _play
        ? _Player(
            streamLink: widget.streamLink,
            playerType: widget.playerType,
          )
        : GestureDetector(
            onTap: _playTapped,
            child: _Background(
              url: widget.background,
              loading: widget.loading,
            ),
          );
  }
}

class _Player extends StatelessWidget {
  final String playerType;
  final String streamLink;
  const _Player({this.playerType, this.streamLink});
  @override
  Widget build(BuildContext context) {
    switch (playerType) {
      case 'YouTube':
        return YoutubePlayer(streamLink: streamLink);
      case 'WebView':
        return WebViewPlayer(streamLink: streamLink, filterUrl: streamLink);
      case 'other':
        return VideoPlayer(videoUrl: streamLink);
      case 'Torrent':
        return WebTorrentPlayer(
          key: ValueKey(streamLink),
          url: streamLink,
        );
      case 'VideoSourceApi':
        return WebViewPlayer(
            streamLink: streamLink, filterUrl: 'https://moviessources.cf');
      default:
        return SizedBox();
    }
  }
}

class VideoPlayer extends StatefulWidget {
  final String videoUrl;
  const VideoPlayer({@required this.videoUrl});
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  ChewieController _chewieController;
  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _videoPlayerController.initialize().then((value) {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        customControls: CustomCupertinoControls(
          backgroundColor: Colors.black,
          iconColor: Colors.white,
        ),
        allowedScreenSleep: false,
        autoPlay: true,
        aspectRatio: _videoPlayerController.value.aspectRatio,
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: _chewieController == null
          ? Center(
              child: Container(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(const Color(0xFFFFFFFF)),
                ),
              ),
            )
          : Chewie(controller: _chewieController),
    );
  }
}

class _Background extends StatelessWidget {
  final String url;
  final bool loading;
  const _Background({@required this.url, this.loading});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFAABBEE),
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            ImageUrl.getUrl(url, ImageSize.original),
          ),
        ),
      ),
      child: loading
          ? Center(
              child: Container(
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(const Color(0xFFFFFFFF)),
                ),
              ),
            )
          : _PlayArrow(),
    );
  }
}

class _PlayArrow extends StatelessWidget {
  const _PlayArrow();
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(Adapt.px(50)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          color: const Color(0x40FFFFFF),
          width: Adapt.px(100),
          height: Adapt.px(100),
          child: Icon(
            Icons.play_arrow,
            size: 25,
            color: const Color(0xFFFFFFFF),
          ),
        ),
      ),
    ));
  }
}
