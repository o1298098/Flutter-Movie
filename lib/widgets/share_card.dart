import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/widgets/shimmercell.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_extend/share_extend.dart';

class ShareCard extends StatefulWidget {
  final String backgroundImage;
  final String qrValue;
  final Widget header;
  final double headerHeight;
  ShareCard(
      {Key key,
      @required this.backgroundImage,
      @required this.qrValue,
      @required this.header,
      this.headerHeight})
      : super(key: key);
  @override
  ShareCardState createState() => ShareCardState();
}

class ShareCardState extends State<ShareCard> {
  String backgroundImage;
  String qrValue;
  Widget header;
  double headerHeight;
  ScreenshotController screenshotController;
  double width = (Adapt.screenW() - Adapt.px(60)).floorToDouble();
  double height = (Adapt.screenH() / 2).floorToDouble();
  @override
  void initState() {
    backgroundImage = widget.backgroundImage;
    qrValue = widget.qrValue;
    header = widget.header;
    screenshotController = ScreenshotController();
    headerHeight =
        widget.headerHeight ?? ((width - Adapt.px(40)) / 2).floorToDouble();
    super.initState();
  }

  Future<Widget> _buildShareCard() async {
    //var paletteGenerator = await PaletteGenerator.fromImageProvider(CachedNetworkImageProvider(backgroundImage));
    //Color maincolor = paletteGenerator==null?Color.fromRGBO(50, 50, 50, 1):paletteGenerator.dominantColor;
    Color maincolor = Color.fromRGBO(70, 70, 70, 1);
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.all(Adapt.px(20)),
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            blurRadius: 20.0,
            spreadRadius: 0.1,
            offset: Offset(0, 5),
            color: Colors.black45),
      ]),
      child: Screenshot(
          controller: screenshotController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: width - Adapt.px(40),
                height: headerHeight,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(Adapt.px(20))),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(backgroundImage))),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                          0.25,
                          0.50,
                          0.75,
                          1.0
                        ],
                        colors: <Color>[
                          maincolor.withOpacity(0.7),
                          maincolor.withOpacity(0.8),
                          maincolor.withOpacity(0.9),
                          maincolor,
                        ]),
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(Adapt.px(20))),
                  ),
                  child: header,
                ),
              ),
              Container(
                height: height - headerHeight,
                decoration: BoxDecoration(
                  color: maincolor,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(Adapt.px(20))),
                ),
                alignment: Alignment.center,
                child: QrImage(
                  backgroundColor: Colors.white,
                  data: qrValue,
                  size: Adapt.px(320),
                ),
              ),
            ],
          )),
    );
  }

  Widget _showShareCard() {
    return FutureBuilder<Widget>(
        future: _buildShareCard(),
        builder: (context, snapshot) {
          var width = Adapt.screenW() - Adapt.px(60);
          var height = Adapt.screenH() / 2;
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container(
                width: width,
                height: height,
                child: Center(
                  child: Text('build failed'),
                ),
              );
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Container(
                margin: EdgeInsets.all(Adapt.px(20)),
                alignment: Alignment.center,
                child: ShimmerCell(width, height, Adapt.px(20)),
              );
            case ConnectionState.done:
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              return snapshot.data;
          }
          return null;
        });
  }

  void shareTapped() {
    screenshotController.capture().then((File image) async {
      ShareExtend.share(image.path, "image");
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Adapt.px(20))),
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: height + Adapt.px(130),
              padding: EdgeInsets.only(top: height / 2),
              child: Container(
                padding: EdgeInsets.only(top: height / 2 + Adapt.px(20)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Adapt.px(30))),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {},
                          child: SizedBox(
                            width: Adapt.px(200),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.file_download),
                                Text(
                                  'DownLoad',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Adapt.px(28),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        width: Adapt.px(30),
                      ),
                      GestureDetector(
                          onTap: shareTapped,
                          child: SizedBox(
                            width: Adapt.px(200),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.share),
                                  Text('Share',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Adapt.px(28),
                                          fontWeight: FontWeight.bold))
                                ]),
                          )),
                    ]),
              ),
            ),
            _showShareCard(),
          ],
        )
      ],
    );
  }
}
