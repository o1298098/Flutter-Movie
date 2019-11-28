import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/models/base_api_model/tvshow_comment.dart';
import 'package:shimmer/shimmer.dart';

import 'dart:ui' as ui;
import 'action.dart';
import 'state.dart';

Widget buildView(
    CommentState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildShimmerCell() {
    final Color _baseColor = Colors.grey;
    final _rightWidth = Adapt.screenW() - Adapt.px(170);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: Adapt.px(30)),
        Container(
          width: Adapt.px(80),
          height: Adapt.px(80),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _baseColor,
          ),
        ),
        SizedBox(width: Adapt.px(30)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: Adapt.px(10)),
            Container(
              width: Adapt.px(300),
              height: Adapt.px(26),
              color: _baseColor,
            ),
            SizedBox(height: Adapt.px(8)),
            Container(
              width: Adapt.px(200),
              height: Adapt.px(22),
              color: _baseColor,
            ),
            SizedBox(height: Adapt.px(40)),
            Container(
              width: _rightWidth,
              height: Adapt.px(22),
              color: _baseColor,
            ),
            SizedBox(height: Adapt.px(8)),
            Container(
              width: _rightWidth,
              height: Adapt.px(22),
              color: _baseColor,
            ),
            SizedBox(height: Adapt.px(8)),
            Container(
              width: Adapt.px(400),
              height: Adapt.px(22),
              color: _baseColor,
            ),
            SizedBox(height: Adapt.px(8)),
          ],
        )
      ],
    );
  }

  List<Widget> _buildShimmerGroup() {
    return [
      Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Column(
          children: <Widget>[
            SizedBox(height: Adapt.px(30)),
            _buildShimmerCell(),
            SizedBox(height: Adapt.px(30)),
            Divider(color: Colors.grey[300]),
            SizedBox(height: Adapt.px(30)),
            _buildShimmerCell(),
            SizedBox(height: Adapt.px(30)),
            Divider(color: Colors.grey[300]),
            SizedBox(height: Adapt.px(30)),
            _buildShimmerCell(),
            SizedBox(height: Adapt.px(30)),
            Divider(color: Colors.grey[300]),
          ],
        ),
      )
    ];
  }

  Widget _buildCommentCell(TvShowComment d) {
    var date = DateTime.parse(d.updateTime ?? '2019-11-25');
    String timeline = TimelineUtil.format(
      date.millisecondsSinceEpoch,
      locTimeMillis: DateTime.now().millisecondsSinceEpoch,
      locale: ui.window.locale.languageCode,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ListTile(
          leading: Container(
            width: Adapt.px(80),
            height: Adapt.px(80),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(d?.u?.photoUrl ?? ''))),
          ),
          title: Text(d.u.userName),
          subtitle: Text(timeline),
          trailing: Icon(Icons.more_vert),
        ),
        Container(
          padding: EdgeInsets.only(
              left: Adapt.px(140), right: Adapt.px(30), bottom: Adapt.px(30)),
          child: Text(d.comment ?? ''),
        ),
        Divider()
      ],
    );
  }

  List<Widget> _buildEmptyComment() {
    return [
      Column(
        children: <Widget>[
          SizedBox(height: Adapt.px(100)),
          Image.asset(
            'images/empty_comment.png',
            fit: BoxFit.cover,
            width: Adapt.px(200),
            height: Adapt.px(200),
          ),
          SizedBox(height: Adapt.px(50)),
          Text(
            'Waiting your comment',
            style:
                TextStyle(fontSize: Adapt.px(45), fontWeight: FontWeight.w600),
          )
        ],
      )
    ];
  }

  return MediaQuery.removePadding(
    context: viewService.context,
    removeTop: true,
    child: ListView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      children: state.comments == null
          ? _buildShimmerGroup()
          : state.comments.data.length > 0
              ? state.comments?.data?.map(_buildCommentCell)?.toList()
              : _buildEmptyComment(),
    ),
  );
}
