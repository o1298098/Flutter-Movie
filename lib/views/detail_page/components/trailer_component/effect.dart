import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'action.dart';
import 'state.dart';

Effect<TrailerState> buildEffect() {
  return combineEffects(<Object, Effect<TrailerState>>{
    TrailerAction.action: _onAction,
    TrailerAction.playTrailer: _playTrailer,
  });
}

void _onAction(Action action, Context<TrailerState> ctx) {}

void _playTrailer(Action action, Context<TrailerState> ctx) async {
  final String _videoKey = action.payload ?? '';
  await showGeneralDialog(
      barrierLabel: 'Trailer',
      barrierDismissible: true,
      barrierColor: Colors.black87,
      transitionDuration: Duration(milliseconds: 300),
      context: ctx.context,
      pageBuilder: (_, __, ___) {
        return _YoutubePlayer(
          videoKey: _videoKey,
        );
      });
}

class _YoutubePlayer extends StatefulWidget {
  final String videoKey;
  _YoutubePlayer({@required this.videoKey});
  @override
  _YoutubePlayerState createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<_YoutubePlayer> {
  YoutubePlayerController _controller;
  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId: widget.videoKey,
        flags: YoutubePlayerFlags(
          autoPlay: true,
        ));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
          progressColors: ProgressBarColors(
            playedColor: Colors.red,
            handleColor: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
