import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as youtube;

class YoutubePlayer extends StatefulWidget {
  final String streamLink;
  const YoutubePlayer({this.streamLink});
  @override
  _YoutubePlayerState createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<YoutubePlayer> {
  youtube.YoutubePlayerController _controller;
  @override
  void initState() {
    _controller = youtube.YoutubePlayerController(
      initialVideoId: widget.streamLink,
      flags: youtube.YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return youtube.YoutubePlayer(
      controller: _controller,
      topActions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
      progressIndicatorColor: Colors.white,
      progressColors: youtube.ProgressBarColors(
        playedColor: Colors.white,
        handleColor: Colors.white,
      ),
    );
  }
}
