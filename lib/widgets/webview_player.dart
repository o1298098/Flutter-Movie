import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewPlayer extends StatefulWidget {
  final String streamLink;
  final String filterUrl;
  const WebViewPlayer({@required this.streamLink, @required this.filterUrl});
  @override
  _WebviewPlayerState createState() => _WebviewPlayerState();
}

class _WebviewPlayerState extends State<WebViewPlayer> {
  String _streamlink;
  bool _loadFinsh;
  bool _fullScreen;

  void init() {
    _loadFinsh = false;
    _fullScreen = false;
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
            src="${widget.streamLink}" 
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
    if (oldWidget.streamLink != widget.streamLink) {
      init();
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF000000),
      child: IndexedStack(
        index: _loadFinsh ? 0 : 1,
        children: [
          InAppWebView(
            initialUrl: _streamlink,
            initialOptions: InAppWebViewGroupOptions(
              android: AndroidInAppWebViewOptions(
                supportMultipleWindows: false,
              ),
              crossPlatform: InAppWebViewOptions(
                javaScriptEnabled: true,
                supportZoom: false,
                disableHorizontalScroll: true,
                disableVerticalScroll: true,
                useShouldOverrideUrlLoading: true,
                mediaPlaybackRequiresUserGesture: false,
                preferredContentMode: UserPreferredContentMode.MOBILE,
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
                      .compareTo(widget.filterUrl) ==
                  0) {
                controller.stopLoading();
              }
              return;
            },
          ),
          Center(
            child: Container(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(const Color(0xFFFFFFFF)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
