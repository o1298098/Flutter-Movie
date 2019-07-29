import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/customwidgets/shimmercell.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/mylistmodel.dart';
import 'dart:ui' as ui;

import 'action.dart';
import 'state.dart';

Widget buildView(
    MyListsPageState state, Dispatch dispatch, ViewService viewService) {
 
  Widget _buildListCell(MyListResult d) {
    var date = DateTime.parse(d.updatedAt);
    return GestureDetector(
      onTap: () => dispatch(MyListsPageActionCreator.cellTapped(d.id)),
      child: Padding(
        padding: EdgeInsets.only(top: Adapt.px(20)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Adapt.px(30)),
          child: Container(
            height: Adapt.px(400),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(ImageUrl.getUrl(d.backdropPath, ImageSize.w300)))),
            child: Container(
              color: Colors.black.withOpacity(0.7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    d.name ?? '',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Adapt.px(45),
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    height: Adapt.px(15),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('${d.numberOfItems} Items',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Adapt.px(30),
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic)),
                      SizedBox(
                        width: Adapt.px(20),
                      ),
                      Container(
                        padding: EdgeInsets.all(Adapt.px(8)),
                        decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(Adapt.px(10))),
                        child: Text(
                          d.public == 1 ? 'PUBLIC' : 'PRIVATE',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Adapt.px(24)),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Adapt.px(8),
                  ),
                  Text(
                    'Updated ' +
                        TimelineUtil.format(
                          DateTime.utc(
                                  date.year,
                                  date.month,
                                  date.day,
                                  date.hour,
                                  date.minute,
                                  date.second,
                                  date.millisecond,
                                  date.microsecond)
                              .millisecondsSinceEpoch,
                          locTimeMillis: DateTime.now().millisecondsSinceEpoch,
                          locale: ui.window.locale.languageCode,
                        ),
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: Adapt.px(28),
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (state.myList.results.length > 0)
      return Container(
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(20)),
        child: ListView(
          controller: state.scrollController,
          children: state.myList.results.map(_buildListCell).toList()
            ..add(Offstage(
              offstage: state.myList.page == state.myList.totalPages,
              child: Container(
                height: Adapt.px(80),
                margin: EdgeInsets.only(top: Adapt.px(30)),
                alignment: Alignment.topCenter,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                ),
              ),
            )),
        ),
      );
    else
      return Container(
        margin: EdgeInsets.symmetric(horizontal: Adapt.px(20)),
        alignment: Alignment.topCenter,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: Adapt.px(20),
            ),
            ShimmerCell(Adapt.screenW(), Adapt.px(400), Adapt.px(30)),
            SizedBox(
              height: Adapt.px(20),
            ),
            ShimmerCell(Adapt.screenW(), Adapt.px(400), Adapt.px(30)),
            SizedBox(
              height: Adapt.px(20),
            ),
            ShimmerCell(Adapt.screenW(), Adapt.px(400), Adapt.px(30)),
            SizedBox(
              height: Adapt.px(20),
            ),
            ShimmerCell(Adapt.screenW(), Adapt.px(400), Adapt.px(30)),
          ],
        ),
      );
  }

  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      title: Text(
        'My Lists',
        style: TextStyle(color: Colors.black),
      ),
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: Colors.black),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.create),
          onPressed: (){},
        ),
      ],
    ),
    body: _buildBody(),
  );
}
