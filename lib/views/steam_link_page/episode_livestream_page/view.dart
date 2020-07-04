import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/creditsmodel.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/episodemodel.dart';
import 'package:movie/models/seasondetail.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/widgets/expandable_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    EpisodeLiveStreamState state, Dispatch dispatch, ViewService viewService) {
  final _theme = ThemeStyle.getTheme(viewService.context);
  return Scaffold(
    backgroundColor: _theme.backgroundColor,
    body: Stack(
      children: [
        Container(
          child: ListView(
            controller: state.scrollController,
            padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
            children: [
              SizedBox(
                height: Adapt.px(30) + Adapt.padTopH(),
              ),
              _Player(
                tvid: state.tvid,
                episode: state.selectedEpisode,
              ),
              _Header(
                episode: state.selectedEpisode,
                season: state.season,
              ),
              _Episodes(
                episodes: state.season.episodes,
                episodeNumber: state.selectedEpisode.episodeNumber,
                onTap: (d) =>
                    dispatch(EpisodeLiveStreamActionCreator.episodeTapped(d)),
              ),
              SizedBox(height: 90),
            ],
          ),
        ),
        Container(
          color: _theme.backgroundColor,
          height: Adapt.padTopH(),
        ),
        _BottomPanel(),
      ],
    ),
  );
}

class _Player extends StatefulWidget {
  final int tvid;
  final Episode episode;
  const _Player({this.tvid, this.episode});
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<_Player> {
  String _streamlink;
  bool _play;
  bool _loadFinsh;

  void init() {
    _loadFinsh = false;
    _play = false;
    _streamlink =
        'https://moviessources.cf/embed/${widget.tvid}/${widget.episode.seasonNumber}-${widget.episode.episodeNumber}';
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  _playTapped() {
    _play = true;
    setState(() {});
  }

  @override
  void didUpdateWidget(_Player oldWidget) {
    if (oldWidget.episode != widget.episode) {
      init();
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Adapt.px(30)),
        child: Container(
          color: const Color(0xFF000000),
          child: _play
              ? IndexedStack(index: _loadFinsh ? 0 : 1, children: [
                  InAppWebView(
                    initialUrl: _streamlink,
                    key: ValueKey(_streamlink),
                    initialHeaders: {},
                    initialOptions: InAppWebViewGroupOptions(
                        android: AndroidInAppWebViewOptions(
                          supportMultipleWindows: false,
                          forceDark: AndroidForceDark.FORCE_DARK_ON,
                        ),
                        crossPlatform: InAppWebViewOptions(
                          useShouldOverrideUrlLoading: true,
                          mediaPlaybackRequiresUserGesture: false,
                          debuggingEnabled: true,
                        )),
                    onProgressChanged: (controller, progress) {
                      print(progress.toString());
                      if (progress == 100 && !_loadFinsh) {
                        _loadFinsh = true;
                        setState(() {});
                      }
                    },
                    onLoadStop: (controller, url) {
                      controller.evaluateJavascript(source: '''
                   function getElementsClass(classnames) {
                      var classobj = new Array();
                      var classint = 0;
                      var tags = document.getElementsByTagName("*");
                      for (var i in tags) {
                       if (tags[i].nodeType == 1) {
                          if (tags[i].getAttribute("class") == classnames) {
                            classobj[classint] = tags[i];
                            classint++;
                          }
                        }
                       }
                      return classobj;
                   }
                    var a = getElementsClass("server-list-btnx btn btn-warning start-animation btn-lg"); 
                    a[0].style.display = "none";
                  ''');
                    },
                    shouldOverrideUrlLoading:
                        (controller, shouldOverrideUrlLoadingRequest) {
                      if (shouldOverrideUrlLoadingRequest.url
                              .compareTo('https://moviessources.cf/embed') ==
                          0) {
                        controller.stopLoading();
                      }
                      return;
                    },
                  ),
                  Center(
                      child: Container(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation(const Color(0xFFFFFFFF)),
                    ),
                  ))
                ])
              : GestureDetector(
                  onTap: _playTapped,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFAABBEE),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          ImageUrl.getUrl(
                              widget.episode.stillPath, ImageSize.original),
                        ),
                      ),
                    ),
                    child: _PlayArrow(),
                  ),
                ),
        ),
      ),
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

class _Header extends StatelessWidget {
  final Episode episode;
  final Season season;
  const _Header({this.episode, this.season});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Adapt.px(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            episode.name,
            style: TextStyle(
              fontSize: Adapt.px(35),
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
          ),
          SizedBox(height: Adapt.px(40)),
          Row(children: [
            Container(
              width: Adapt.px(80),
              height: Adapt.px(80),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Adapt.px(20)),
                image: season.posterPath != null
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          ImageUrl.getUrl(season.posterPath, ImageSize.w300),
                        ),
                      )
                    : null,
              ),
            ),
            SizedBox(width: Adapt.px(10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(season.name),
                Text(
                  DateFormat.yMMMd().format(DateTime.parse(season.airDate)),
                  style: TextStyle(
                    fontSize: Adapt.px(24),
                    color: const Color(0xFF717171),
                  ),
                ),
              ],
            ),
            Spacer(),
            _CastCell(casts: season.credits.cast)
          ]),
          SizedBox(height: Adapt.px(40)),
          ExpandableText(
            season.overview,
            maxLines: 3,
            style: TextStyle(color: const Color(0xFF717171), height: 1.5),
          )
        ],
      ),
    );
  }
}

class _CastCell extends StatelessWidget {
  final List<CastData> casts;
  const _CastCell({this.casts});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Container(
      width: Adapt.px(240),
      child: Row(
        children: casts
            .take(4)
            .map((e) {
              final int _index = casts.indexOf(e);
              return Container(
                width: Adapt.px(60),
                height: Adapt.px(60),
                transform: Matrix4.translationValues(10.0 * _index, 0, 0),
                decoration: BoxDecoration(
                  color: _theme.primaryColorDark,
                  border: Border.all(
                    color: const Color(0xFFFFFFFF),
                    width: 1,
                  ),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                        ImageUrl.getUrl(e.profilePath, ImageSize.w300)),
                  ),
                ),
              );
            })
            .toList()
            .reversed
            .toList(),
      ),
    );
  }
}

class _Episodes extends StatelessWidget {
  final List<Episode> episodes;
  final int episodeNumber;
  final Function(Episode) onTap;

  const _Episodes({this.episodes, this.episodeNumber, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Adapt.px(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Next Episode',
            style: TextStyle(
              fontSize: Adapt.px(30),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: Adapt.px(30)),
          ListView.separated(
              padding: EdgeInsets.zero,
              physics: PageScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (_, __) => SizedBox(height: Adapt.px(30)),
              itemCount: episodes.length,
              itemBuilder: (_, index) {
                int _episodeIndex = episodeNumber - 1;
                int _d = _episodeIndex + index;
                final int _index =
                    _d < episodes.length ? _d : _d - episodes.length;
                return _EpisodeCell(
                  episode: episodes[_index],
                  onTap: onTap,
                );
              })
        ],
      ),
    );
  }
}

class _EpisodeCell extends StatelessWidget {
  final Episode episode;
  final Function(Episode) onTap;
  const _EpisodeCell({this.episode, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(episode),
      child: Row(
        children: [
          Container(
            width: Adapt.px(220),
            height: Adapt.px(122),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Adapt.px(15)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  ImageUrl.getUrl(episode.stillPath, ImageSize.w300),
                ),
              ),
            ),
          ),
          SizedBox(width: Adapt.px(20)),
          SizedBox(
            width: Adapt.screenW() - Adapt.px(320),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EP${episode.episodeNumber}',
                  style: TextStyle(
                      fontSize: Adapt.px(28), fontWeight: FontWeight.bold),
                ),
                Text(episode.name),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _BottomPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
        decoration: BoxDecoration(
          color: _theme.brightness == Brightness.light
              ? const Color(0xFF25272E)
              : _theme.primaryColorDark,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(Adapt.px(60)),
          ),
        ),
        child: Row(children: [
          Icon(
            Icons.favorite,
            size: Adapt.px(30),
            color: const Color(0xFFAA222E),
          ),
          SizedBox(width: Adapt.px(10)),
          Text(
            '0',
            style: TextStyle(color: const Color(0xFFFFFFFF)),
          ),
          SizedBox(width: Adapt.px(50)),
          Icon(
            Icons.comment,
            size: Adapt.px(30),
            color: const Color(0xFFFFFFFF),
          ),
          SizedBox(width: Adapt.px(10)),
          Text(
            '0',
            style: TextStyle(color: const Color(0xFFFFFFFF)),
          ),
          SizedBox(width: Adapt.px(50)),
          Icon(
            Icons.file_download,
            size: Adapt.px(30),
            color: const Color(0xFFFFFFFF),
          ),
          SizedBox(width: Adapt.px(10)),
          Text(
            'Download',
            style: TextStyle(color: const Color(0xFFFFFFFF)),
          ),
          Spacer(),
          Icon(
            Icons.more_vert,
            color: const Color(0xFFFFFFFF),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.keyboard_arrow_down,
              size: Adapt.px(60),
              color: const Color(0xFFFFFFFF),
            ),
          ),
        ]),
      ),
    );
  }
}
