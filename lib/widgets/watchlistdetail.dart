import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/video_list.dart';
import 'package:video_player/video_player.dart';

class WatchlistDetail extends StatefulWidget {
  final int initialIndex;
  final VideoListModel data;

  WatchlistDetail({this.initialIndex, this.data});
  @override
  WatchlistDetailState createState() => WatchlistDetailState();
}

class WatchlistDetailState extends State<WatchlistDetail>
    with TickerProviderStateMixin {
  double startY;
  double endY;
  VideoPlayerController videoPlayerController;
  AnimationController animationController;
  FadeAnimation imageFadeAnim =
      FadeAnimation(child: const Icon(Icons.play_arrow, size: 100.0));
  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4');
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    videoPlayerController.initialize();
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[
      GestureDetector(
        child: VideoPlayer(videoPlayerController),
        onTap: () {
          if (!videoPlayerController.value.initialized) {
            return;
          }
          if (videoPlayerController.value.isPlaying) {
            imageFadeAnim =
                FadeAnimation(child: const Icon(Icons.pause, size: 100.0));
            videoPlayerController.pause();
          } else {
            imageFadeAnim =
                FadeAnimation(child: const Icon(Icons.play_arrow, size: 100.0));
            videoPlayerController.play();
          }
        },
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: VideoProgressIndicator(
          videoPlayerController,
          allowScrubbing: true,
        ),
      ),
      Center(child: imageFadeAnim),
      Center(
          child: videoPlayerController.value.isBuffering
              ? const CircularProgressIndicator()
              : null),
    ];
    return GestureDetector(
      onVerticalDragUpdate: (dragUpdateDetails) {
        endY = dragUpdateDetails.globalPosition.dy;
        print(
            'dragUpdateDetails-' + dragUpdateDetails.globalPosition.toString());
        print('dddd' + (endY - startY).toString());
        if (endY - startY > 150 && startY <= 150) Navigator.of(context).pop();
      },
      onVerticalDragStart: (dragStartDetails) {
        startY = dragStartDetails.localPosition.dy;
        print('dragStartDetails' + dragStartDetails.localPosition.toString());
      },
      onVerticalDragEnd: (dragEndDetails) {
        if (endY - startY < 150) animationController.reverse();
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Adapt.px(30)),
              topRight: Radius.circular(Adapt.px(30)),
            ),
            child: Container(
              height: Adapt.screenH() * 0.8,
              color: Colors.white,
              padding: EdgeInsets.only(top: Adapt.px(30)),
              child: PageView.builder(
                controller: PageController(initialPage: widget.initialIndex),
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                pageSnapping: true,
                itemBuilder: (ctx, index) {
                  return Stack(
                    children: <Widget>[
                      Material(
                        child: Container(
                          width: Adapt.screenW(),
                          height: Adapt.screenH() * 0.8,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                      Colors.white, BlendMode.color),
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                      ImageUrl.getUrl(
                                          widget.data.results[index].posterPath,
                                          ImageSize.w300)))),
                          child: Container(
                            color: Colors.white.withAlpha(240),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              color: Colors.black,
                              height: Adapt.px(400),
                              child: Stack(
                                fit: StackFit.passthrough,
                                children: children,
                              ),
                            ),
                            Text(
                              widget.data.results[index].name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Adapt.px(45)),
                            ),
                            Text(
                              widget.data.results[index].overview,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                itemCount: widget.data.results.length,
              ),
            ),
          )),
    );
  }
}

class FadeAnimation extends StatefulWidget {
  FadeAnimation(
      {this.child, this.duration = const Duration(milliseconds: 500)});

  final Widget child;
  final Duration duration;

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: widget.duration, vsync: this);
    animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    animationController.forward(from: 0.0);
  }

  @override
  void deactivate() {
    animationController.stop();
    super.deactivate();
  }

  @override
  void didUpdateWidget(FadeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child) {
      animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return animationController.isAnimating
        ? Opacity(
            opacity: 1.0 - animationController.value,
            child: widget.child,
          )
        : Container();
  }
}

typedef Widget VideoWidgetBuilder(
    BuildContext context, VideoPlayerController controller);

abstract class PlayerLifeCycle extends StatefulWidget {
  PlayerLifeCycle(this.dataSource, this.childBuilder);

  final VideoWidgetBuilder childBuilder;
  final String dataSource;
}
