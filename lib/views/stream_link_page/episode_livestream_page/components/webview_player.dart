import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/episodemodel.dart';

class WebViewPlayer extends StatefulWidget {
  final int tvid;
  final Episode episode;
  const WebViewPlayer({this.tvid, this.episode});
  @override
  _WebviewPlayerState createState() => _WebviewPlayerState();
}

class _WebviewPlayerState extends State<WebViewPlayer> with AutomaticKeepAliveClientMixin {
  String _streamlink;
  bool _play;
  bool _loadFinsh;
  bool _fullScreen;

  @override
  bool get wantKeepAlive => true;

  void init() {
    _loadFinsh = false;
    _fullScreen = false;
    _play = false;
    _streamlink = Uri.dataFromString(
      '''
            <html>
            <header>
            <meta name="viewport" 
            content="maximum-scale=1.0,minimum-scale=1.0,user-scalable=0,width=device-width,initial-scale=1.0"/>
            </header>
            <body style="margin:0;background-color:#000;">
            <iframe 
            frameborder="0"
            width="100%" 
            height="100%" 
            src="https://moviessources.cf/embed/${widget.tvid}/${widget.episode.seasonNumber}-${widget.episode.episodeNumber}" 
            allowfullscreen>
            </iframe>
            </body>
            </html>
      ''',
      mimeType: 'text/html',
    ).toString();
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  _playTapped() async {
    setState(() {
      _play = true;
    });
  }

  _toggleFullScreenMode(bool fullScreen) {
    _fullScreen = fullScreen;
    if (_fullScreen) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  @override
  void didUpdateWidget(WebViewPlayer oldWidget) {
    if (oldWidget.episode != widget.episode) {
      init();
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                      ),
                      crossPlatform: InAppWebViewOptions(
                        supportZoom: false,
                        disableHorizontalScroll: true,
                        disableVerticalScroll: true,
                        useShouldOverrideUrlLoading: true,
                        mediaPlaybackRequiresUserGesture: false,
                        debuggingEnabled: true,
                      ),
                    ),
                    onProgressChanged: (controller, progress) {
                      print(progress.toString());
                      if (progress == 100 && !_loadFinsh) {
                        _loadFinsh = true;
                        setState(() {});
                      }
                    },
                    onEnterFullscreen: (_) {
                      _toggleFullScreenMode(true);
                    },
                    onExitFullscreen: (_) {
                      _toggleFullScreenMode(false);
                    },
                    onLoadStop: (controller, url) {
                      controller.evaluateJavascript(source: '''
                   function getElementsClass(classnames) {
                      var classobj = new Array();
                      var classint = 0;
                      var tags = document.getElementsByTagName("*");
                      for (var i in tags) {
                       if (tags[i].nodeType == 1) {
                          if (tags[i].getAttribute("class")==classnames) {
                            classobj[classint] = tags[i];
                            classint++;
                          }
                        }
                       }
                      return classobj;
                   }
                  var a = getElementsClass("server-list-btnx btn btn-warning start-animation btn-lg mobile-responsive");
                  if(a) {
                    a[0].style.display = "none";
                  }                  
                  ''');
                    },
                    shouldOverrideUrlLoading:
                        (controller, shouldOverrideUrlLoadingRequest) {
                      if (shouldOverrideUrlLoadingRequest.url
                              .compareTo('https://moviessources.cf') ==
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