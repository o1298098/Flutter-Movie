import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/image_model.dart';
import 'package:movie/models/video_model.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/widgets/expandable_text.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'state.dart';

Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
  return SliverToBoxAdapter(
    child: _HeaderPanel(
      backgroundUrl: state.posterurl,
      title: state.name,
      seasonName: state.seasonName,
      overview: state.overwatch,
      images: state.images,
      videos: state.videos,
    ),
  );
}

class _HeaderPanel extends StatelessWidget {
  final String title;
  final String seasonName;
  final String backgroundUrl;
  final ImageModel images;
  final VideoModel videos;
  final String overview;
  const _HeaderPanel(
      {this.backgroundUrl,
      this.seasonName,
      this.title,
      this.overview,
      this.images,
      this.videos});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Adapt.screenW(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Adapt.px(40), vertical: Adapt.px(30)),
            child: Text(
              seasonName,
              style: TextStyle(
                fontSize: Adapt.px(50),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _SwiperPanel(
            backdrops: images?.posters ?? [],
            videos: videos?.results ?? [],
          ),
          overview != null && overview != ''
              ? _OverviewPanel(
                  overview: overview,
                )
              : SizedBox()
        ],
      ),
    );
  }
}

class _OverviewPanel extends StatelessWidget {
  final String overview;
  const _OverviewPanel({this.overview});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Adapt.px(40), vertical: Adapt.px(30)),
          child: Text(
            'Overview',
            style: TextStyle(
              fontSize: Adapt.px(30),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
          child: ExpandableText(
            overview ?? '',
            maxLines: 3,
            style: TextStyle(
              fontSize: Adapt.px(24),
              color: const Color(0xFF717171),
            ),
          ),
        )
      ],
    );
  }
}

class _SwiperPanel extends StatefulWidget {
  final List<VideoResult> videos;
  final List<ImageData> backdrops;
  const _SwiperPanel({this.videos, this.backdrops});
  @override
  _SwiperPanelState createState() => _SwiperPanelState();
}

class _SwiperPanelState extends State<_SwiperPanel> {
  int _currentIndex;
  @override
  void initState() {
    _currentIndex = 0;
    super.initState();
  }

  _setCurrectIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _padding = Adapt.px(40);
    final _size = Adapt.screenW() - _padding * 2;
    return Container(
      height: _size + Adapt.px(30),
      child: Column(
        children: [
          SizedBox(
            height: _size,
            child: Swiper(
              itemCount: 5,
              onIndexChanged: _setCurrectIndex,
              itemWidth: Adapt.screenW(),
              itemBuilder: (context, index) {
                if (index == 0 && widget.videos.length > 0) {
                  return _VideoCell(
                    videos: widget.videos,
                  );
                }
                return _ImageCell(
                  url: widget.backdrops.length > index + 1
                      ? widget.backdrops[index].filePath
                      : null,
                );
              },
            ),
          ),
          SizedBox(height: Adapt.px(20)),
          _SwiperPagination(
            lenght: 5,
            currentIndex: _currentIndex,
          ),
        ],
      ),
    );
  }
}

class _SwiperPagination extends StatelessWidget {
  final int lenght;
  final int currentIndex;
  const _SwiperPagination({this.lenght, this.currentIndex});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _cellWidth = Adapt.px(20);
    final _height = Adapt.px(6);
    final _width =
        lenght > 0 ? _cellWidth * lenght + Adapt.px(10) * (lenght - 1) : 0.0;
    return Container(
        width: _width,
        height: _height,
        child: Align(
          alignment: Alignment.center,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => SizedBox(width: Adapt.px(10)),
            itemCount: lenght,
            itemBuilder: (_, index) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: _cellWidth,
                height: _height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_height / 2),
                  color: index == currentIndex
                      ? _theme.iconTheme.color
                      : _theme.primaryColorDark,
                ),
              );
            },
          ),
        ));
  }
}

class _ImageCell extends StatelessWidget {
  final String url;
  const _ImageCell({this.url});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _margin = Adapt.px(40);
    final _size = Adapt.screenW() - 2 * _margin;
    return Container(
      width: _size,
      height: _size,
      margin: EdgeInsets.symmetric(horizontal: _margin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Adapt.px(30)),
        color: _theme.primaryColorDark,
        image: url == null
            ? null
            : DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  ImageUrl.getUrl(url, ImageSize.w500),
                ),
              ),
      ),
    );
  }
}

class _VideoCell extends StatefulWidget {
  final List<VideoResult> videos;
  const _VideoCell({this.videos});
  @override
  _VideoCellState createState() => _VideoCellState();
}

class _VideoCellState extends State<_VideoCell> {
  YoutubePlayerController _youtubePlayerController;
  String _videoId = '';
  bool _playVideo = false;

  @override
  void didUpdateWidget(_VideoCell oldWidget) {
    if (oldWidget.videos != widget.videos) _updateYoutubeController();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _youtubePlayerController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _updateYoutubeController();
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: _videoId,
    );
    super.initState();
  }

  _updateYoutubeController() {
    if ((widget.videos?.length ?? 0) > 0) {
      _videoId = widget.videos[0].key;
      setState(() {});
    }
  }

  _startPlayVideo(bool play) {
    if (!play) {
      _youtubePlayerController.reset();
      _youtubePlayerController.reload();
    } else
      _youtubePlayerController.play();
    setState(() {
      _playVideo = play;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final double _padding = Adapt.px(40);
    final _size = Adapt.screenW() - _padding * 2;
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: _padding),
          height: _size,
          width: _size,
          decoration: BoxDecoration(
            color: _theme.primaryColorDark,
            borderRadius: BorderRadius.circular(Adapt.px(25)),
            image: (widget.videos.length ?? 0) > 0
                ? DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                        'https://i.ytimg.com/vi/${widget.videos[0]?.key ?? ''}/hqdefault.jpg'),
                  )
                : null,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0x55000000),
              borderRadius: BorderRadius.circular(Adapt.px(25)),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => _startPlayVideo(true),
          child: Container(
            height: _size,
            alignment: Alignment.center,
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
            ),
          ),
        ),
        _VideoPlayer(
          controller: _youtubePlayerController,
          play: _playVideo,
          onEnd: () => _startPlayVideo(false),
        )
      ],
    );
  }
}

class _VideoPlayer extends StatelessWidget {
  final YoutubePlayerController controller;
  final bool play;
  final Function onEnd;
  const _VideoPlayer({this.controller, this.play, this.onEnd});
  @override
  Widget build(BuildContext context) {
    final double _padding = Adapt.px(40);
    final _size = Adapt.screenW() - _padding * 2;
    return play
        ? Container(
            margin: EdgeInsets.symmetric(horizontal: _padding),
            height: _size,
            width: _size,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Adapt.px(25)),
              child: YoutubePlayer(
                controller: controller,
                onEnded: (d) => onEnd(),
                progressColors: ProgressBarColors(
                  playedColor: const Color(0xFFFFFFFF),
                  handleColor: const Color(0xFFFFFFFF),
                  bufferedColor: const Color(0xFFE0E0E0),
                ),
              ),
            ),
          )
        : SizedBox();
  }
}
