import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:video_player/video_player.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    StreamLinksPageState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildCell(DocumentSnapshot d) {
    return Container(
      height: Adapt.px(500),
      decoration: BoxDecoration(
          color: Colors.grey,
          image: DecorationImage(
              image: CachedNetworkImageProvider(
                  ImageUrl.getUrl(d['photourl'], ImageSize.w300)))),
    );
  }

  Widget _buildBody() {
    return StreamBuilder<QuerySnapshot>(
        stream: state.snapshot,
        builder: (_, snapshot) {
          if (!snapshot.hasData)
            return Container(
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Color(0xFF505050)),
                ),
              ),
            );
          snapshot.data.documents.forEach((doc) {
            println(doc.documentID);
          });
          return GridView.count(
            shrinkWrap: true,
            childAspectRatio: 2 / 3,
            crossAxisCount: 3,
            children: snapshot.data.documents.map(_buildCell).toList(),
          );
        });
  }

  return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          _buildBody(),
        ],
      ));
}
