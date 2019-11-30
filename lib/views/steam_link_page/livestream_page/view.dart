import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common_utils/common_utils.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/customwidgets/shimmercell.dart';
import 'package:movie/customwidgets/sliverappbar_delegate.dart';
import 'package:movie/models/enums/streamlink_type.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'dart:ui' as ui;

import 'action.dart';
import 'state.dart';

Widget buildView(
    LiveStreamPageState state, Dispatch dispatch, ViewService viewService) {
  Widget _getPlayer() {
    double _height = Adapt.screenW() * 9 / 16;
    String key = state.streamLinkType?.name ?? '';
    switch (key) {
      case 'YouTube':
        return YoutubePlayer(
          controller: state.youtubePlayerController,
          topActions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: Adapt.px(80),
              ),
              onPressed: () => Navigator.of(viewService.context).pop(),
            )
          ],
          progressIndicatorColor: Colors.red,
          progressColors: ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
        );
      case 'WebView':
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: WebView(
            key: ValueKey(state.streamAddress),
            initialUrl: state.streamAddress,
            javascriptMode: JavascriptMode.unrestricted,
            debuggingEnabled: true,
            navigationDelegate: (NavigationRequest request) {
              if (request.url != state.streamAddress)
                return NavigationDecision.prevent;
              return NavigationDecision.navigate;
            },
          ),
        );
      case 'other':
        return Container(
          color: Colors.black,
          alignment: Alignment.bottomCenter,
          height: _height,
          child: state.chewieController != null
              ? Chewie(
                  key: ValueKey(state.chewieController),
                  controller: state.chewieController)
              : SizedBox(),
        );
      default:
        return Container(
          height: _height,
          color: Colors.black,
        );
    }
  }

  Widget _buildVideoPlayer() {
    double _height = Adapt.screenW() * 9 / 16;
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
          maxHeight: _height + Adapt.padTopH(),
          minHeight: _height + Adapt.padTopH(),
          child: Container(
            color: Colors.black,
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.black,
                  height: Adapt.padTopH(),
                ),
                _getPlayer()
              ],
            ),
          )),
    );
  }

  Widget _buildHeaderInfo() {
    return SliverToBoxAdapter(
        key: ValueKey('HeaderInfo'),
        child: Container(
          padding: EdgeInsets.all(Adapt.px(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  state.name ?? 'no title',
                  style: TextStyle(
                      fontSize: Adapt.px(50), fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: Adapt.px(20)),
              Row(
                children: <Widget>[
                  Text(state.releaseDate ?? ''),
                  SizedBox(width: Adapt.px(20)),
                  RatingBarIndicator(
                    itemSize: Adapt.px(30),
                    itemPadding: EdgeInsets.symmetric(horizontal: Adapt.px(2)),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    unratedColor: Colors.grey,
                    rating: (state.rated ?? 0) / 2,
                  ),
                  SizedBox(width: Adapt.px(8)),
                  Text('${state.rated}   (${state.rateCount})')
                ],
              )
            ],
          ),
        ));
  }

  Widget _buildLinkGroup() {
    double padding = Adapt.px(30);
    return SliverToBoxAdapter(
      child: Container(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Stream Links',
                style: TextStyle(
                    fontSize: Adapt.px(40), fontWeight: FontWeight.w500),
              ),
              SizedBox(height: Adapt.px(30)),
              Container(
                  padding: EdgeInsets.all(padding),
                  width: Adapt.screenW() - padding * 2,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(Adapt.px(20))),
                  child: (state?.streamLinks?.length ?? 0) > 0
                      ? Wrap(
                          spacing: Adapt.px(20),
                          children: state.streamLinks.map((f) {
                            return ChoiceChip(
                              key: ValueKey(f.linkName + f.streamLink),
                              onSelected: (b) => dispatch(
                                  LiveStreamPageActionCreator.chipSelected(f)),
                              selectedColor: Color(0xFF505050),
                              disabledColor: Colors.white,
                              labelStyle: TextStyle(
                                  color: f.selected
                                      ? Color(0xFFFFFFFF)
                                      : Colors.black,
                                  fontSize: Adapt.px(30)),
                              label: Text(f.linkName ?? ''),
                              selected: f.selected,
                            );
                          }).toList())
                      : Padding(
                          padding: EdgeInsets.symmetric(vertical: Adapt.px(10)),
                          child: Row(
                            children: <Widget>[
                              ShimmerCell(
                                Adapt.px(120),
                                Adapt.px(60),
                                Adapt.px(30),
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.grey[200],
                              ),
                              SizedBox(width: Adapt.px(20)),
                              ShimmerCell(
                                Adapt.px(120),
                                Adapt.px(60),
                                Adapt.px(30),
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.grey[200],
                              )
                            ],
                          ),
                        ))
            ],
          )),
    );
  }

  Widget _buildCommentsTitle() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
                Adapt.px(30), Adapt.px(30), Adapt.px(30), Adapt.px(20)),
            child: Text(
              'Comments',
              style: TextStyle(
                  fontSize: Adapt.px(40), fontWeight: FontWeight.w500),
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(width: Adapt.px(30)),
              Container(
                width: Adapt.px(80),
                height: Adapt.px(80),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            state?.user?.photoUrl ?? ''))),
              ),
              SizedBox(width: Adapt.px(30)),
              Container(
                width: Adapt.screenW() - Adapt.px(180),
                height: Adapt.px(100),
                child: TextField(
                  controller: state.commentController,
                  focusNode: state.commentFocusNode,
                  cursorColor: Colors.grey,
                  onSubmitted: (s) {
                    dispatch(LiveStreamPageActionCreator.addComment(s));
                  },
                  onChanged: (s) =>
                      dispatch(LiveStreamPageActionCreator.commentChanged(s)),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: Adapt.px(35)),
                    labelStyle: TextStyle(fontSize: Adapt.px(35)),
                    suffix: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () => dispatch(
                          LiveStreamPageActionCreator.addComment(
                              state.comment)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0)),
                    hintText: 'Add a comment',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommentCell(DocumentSnapshot d) {
    Timestamp timestamp = d['createTime'];
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    String timeline = TimelineUtil.format(
      date.millisecondsSinceEpoch,
      locTimeMillis: DateTime.now().millisecondsSinceEpoch,
      locale: ui.window.locale.languageCode,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Divider(),
        ListTile(
          leading: Container(
            width: Adapt.px(80),
            height: Adapt.px(80),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
                image: DecorationImage(
                    image:
                        CachedNetworkImageProvider(d['userPhotoUrl'] ?? ''))),
          ),
          title: Text(d['userName']),
          subtitle: Text(timeline),
          trailing: Icon(Icons.more_vert),
        ),
        Padding(
          padding: EdgeInsets.only(left: Adapt.px(140), right: Adapt.px(30)),
          child: Text(
            d['comment'],
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
                child: Text(d['like'].toString()),
              ),
              Icon(Icons.thumb_down, color: Colors.grey),
            ],
          ),
        ),
        SizedBox(height: Adapt.px(30)),
      ],
    );
  }

  Widget _buildCommentsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('StreamLinks')
          .document('Movie${state.id}')
          .collection('Comments')
          .orderBy('createTime', descending: true)
          .snapshots(),
      builder: (_, snapshot) {
        if (!snapshot.hasData)
          return SliverToBoxAdapter(
            child: Container(
                height: Adapt.px(300),
                child: Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Color(0xFF505050)),
                ))),
          );
        return SliverList(
          delegate: SliverChildListDelegate(
              snapshot.data.documents.map(_buildCommentCell).toList()),
        );
      },
    );
  }

  Widget _buildBody() {
    return CustomScrollView(
      slivers: <Widget>[
        _buildVideoPlayer(),
        _buildHeaderInfo(),
        _buildLinkGroup(),
        _buildCommentsTitle(),
        _buildCommentsList()
      ],
    );
  }

  return Scaffold(
    body: _buildBody(),
  );
}
