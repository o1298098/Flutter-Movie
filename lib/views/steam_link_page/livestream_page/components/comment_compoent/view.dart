import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/base_api_model/movie_comment.dart';
import 'package:movie/style/themestyle.dart';

import 'dart:ui' as ui;
import 'state.dart';

Widget buildView(
    CommentState state, Dispatch dispatch, ViewService viewService) {
  return state.comments == null
      ? SliverToBoxAdapter(
          child: Container(
            height: Adapt.px(300),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Color(0xFF505050)),
              ),
            ),
          ),
        )
      : state.comments.data.length > 0
          ? SliverList(
              delegate: SliverChildListDelegate(state.comments.data
                  .map((e) => _CommentCell(data: e))
                  .toList()),
            )
          : SliverToBoxAdapter(
              child: Container(
                height: Adapt.px(300),
                child: Center(
                  child: Image.asset('images/empty_comment.png'),
                ),
              ),
            );
}

class _CommentCell extends StatelessWidget {
  final MovieComment data;
  const _CommentCell({this.data});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    final date = DateTime.parse(data.createTime);
    final String timeline = TimelineUtil.format(
      date.millisecondsSinceEpoch,
      locTimeMillis: DateTime.now().millisecondsSinceEpoch,
      locale: ui.window.locale.languageCode,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          leading: Container(
            width: Adapt.px(80),
            height: Adapt.px(80),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _theme.primaryColorDark,
                image: DecorationImage(
                    image: CachedNetworkImageProvider(data.u.photoUrl ?? ''))),
          ),
          title: Text(data.u.userName),
          subtitle: Text(timeline),
          trailing: Icon(Icons.more_vert),
        ),
        Padding(
          padding: EdgeInsets.only(left: Adapt.px(140), right: Adapt.px(30)),
          child: Text(
            data.comment,
            style: TextStyle(fontSize: Adapt.px(30)),
          ),
        ),
        SizedBox(height: Adapt.px(30)),
        Padding(
          padding: EdgeInsets.only(left: Adapt.px(140), right: Adapt.px(30)),
          child: Row(
            children: <Widget>[
              Icon(Icons.thumb_up, color: Colors.grey),
              SizedBox(width: Adapt.px(10)),
              Container(
                width: Adapt.px(100),
                child: Text(data.like.toString()),
              ),
              Icon(Icons.thumb_down, color: Colors.grey),
            ],
          ),
        ),
        SizedBox(height: Adapt.px(30)),
        Divider(),
      ],
    );
  }
}
