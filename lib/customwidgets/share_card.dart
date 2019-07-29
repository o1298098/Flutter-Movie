import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/customwidgets/shimmercell.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_extend/share_extend.dart';

class ShareCard extends StatefulWidget {
  final String backgroundImage;
  final String qrValue;
  final Widget header;
  final double headerHeight;
  ShareCard({@required this.backgroundImage,@required this.qrValue,@required this.header,this.headerHeight});
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
    screenshotController=ScreenshotController();
    headerHeight=widget.headerHeight??((width - Adapt.px(40)) / 2).floorToDouble();
    super.initState();
  }

  Future<Widget> _buildShareCard() async {
    var paletteGenerator = await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(backgroundImage));
    Color maincolor =
        paletteGenerator.dominantColor?.color ?? Color.fromRGBO(50, 50, 50, 1);
    return Screenshot(
      controller: screenshotController,
      child: Container(
          width: width,
          height: height,
          margin: EdgeInsets.all(Adapt.px(20)),
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
  
  void shareTapped(){
    screenshotController.capture().then((File image) async {
      ShareExtend.share(image.path, "image");
    }).catchError((onError) {
      print(onError);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Adapt.px(20))),
      children: <Widget>[
        _showShareCard(),
        Container(
          padding: EdgeInsets.only(bottom: Adapt.px(20)),
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
                                fontSize: Adapt.px(30),
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
                                    fontSize: Adapt.px(30),
                                    fontWeight: FontWeight.bold))
                          ]),
                    )),
              ]),
        )
      ],
    );
  }
}
