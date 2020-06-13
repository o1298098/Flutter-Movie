import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerItem extends StatefulWidget {
  final VideoPlayerController vc;
  final String coverurl;
  final bool showplayer;
  final int playtime;
  final int duration;
  VideoPlayerItem(
      {@required this.vc,
      this.coverurl,
      this.showplayer,
      this.playtime,
      this.duration,
      Key key})
      : super(key: key);
  @override
  VideoPlayerItemState createState() => VideoPlayerItemState();
}

class VideoPlayerItemState extends State<VideoPlayerItem> {
  ChewieController chewieController;
  VideoPlayerController vc;
  bool showplayer = true;
  void playButtonClicked() {
    if (!vc.value.initialized) {
      vc.initialize().then((_) {
        setState(() {
          showplayer = false;
        });
        vc.play();
      });
    } else if (!vc.value.isPlaying) {
      setState(() {
        showplayer = false;
      });
      vc.play();
    } else {
      setState(() {
        showplayer = true;
      });
      vc.pause();
    }
  }

  @override
  void initState() {
    setState(() {
      showplayer = widget.showplayer;
    });
    vc = widget.vc;
    chewieController = new ChewieController(
      videoPlayerController: vc,
      aspectRatio: 16 / 9,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    vc.pause();
    //vc.dispose();
    chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Adapt.screenW(),
        height: Adapt.screenW() * 9 / 16,
        child: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: new FittedBox(
                  fit: BoxFit.cover,
                  child: FadeInImage.assetNetwork(
                    placeholder: 'images/CacheBG.jpg',
                    image: widget.coverurl,
                  )),
            ),
            Container(
              color: Colors.black38,
            ),
            Center(
              child: IconButton(
                iconSize: Adapt.px(120),
                icon: Icon(Icons.play_circle_outline),
                color: Colors.white,
                onPressed: playButtonClicked,
              ),
            ),
            Offstage(
              offstage: showplayer,
              child: Container(
                child: Chewie(
                  key: Key(chewieController.videoPlayerController.dataSource),
                  controller: chewieController,
                ),
              ),
            ),
          ],
        ));
  }
}
