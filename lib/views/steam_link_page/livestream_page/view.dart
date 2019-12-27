import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:common_utils/common_utils.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/customwidgets/sliverappbar_delegate.dart';
import 'package:movie/models/base_api_model/movie_comment.dart';
import 'package:movie/models/base_api_model/movie_stream_link.dart';
import 'package:movie/style/themestyle.dart';
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
          child: InAppWebView(
              key: ValueKey(state.streamAddress),
              initialUrl: state.streamAddress,
              initialHeaders: {},
              initialOptions: InAppWebViewWidgetOptions(
                  inAppWebViewOptions: InAppWebViewOptions(
                debuggingEnabled: true,
              ))),
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
              : SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
                ),
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

  return Builder(builder: (context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    final ThemeData _theme = ThemeStyle.getTheme(context);
    Widget _buildStreamLinkCell(MovieStreamLink d) {
      return GestureDetector(
          onTap: () {
            if (!d.selected)
              dispatch(LiveStreamPageActionCreator.chipSelected(d));
          },
          child: Container(
            margin: EdgeInsets.only(left: Adapt.px(30)),
            padding: EdgeInsets.all(Adapt.px(20)),
            width: Adapt.px(300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Adapt.px(20)),
              border: Border.all(
                  color: d.selected
                      ? _mediaQuery.platformBrightness == Brightness.light
                          ? Colors.black
                          : Colors.white
                      : Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${d.linkName}'),
                    SizedBox(height: Adapt.px(15)),
                    Text(
                      '${d.language.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(color: Colors.grey, fontSize: Adapt.px(30)),
                    ),
                  ],
                ),
                Container(
                  height: Adapt.px(45),
                  padding: EdgeInsets.all(Adapt.px(10)),
                  decoration: BoxDecoration(
                      color: Color(0xFF505050),
                      borderRadius: BorderRadius.circular(Adapt.px(25))),
                  child: Text(
                    d.quality.name,
                    style:
                        TextStyle(color: Colors.white, fontSize: Adapt.px(20)),
                  ),
                )
              ],
            ),
          ));
    }

    Widget _buildShimmerLinkCell() {
      return Container(
        margin: EdgeInsets.only(left: Adapt.px(30)),
        width: Adapt.px(300),
        decoration: BoxDecoration(
          color: _theme.primaryColorLight,
          borderRadius: BorderRadius.circular(Adapt.px(20)),
        ),
      );
    }

    Widget _buildLinkGroup() {
      return SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(
                  Adapt.px(30), Adapt.px(30), Adapt.px(30), 0),
              child: Text(
                'Stream Links',
                style: TextStyle(
                    fontSize: Adapt.px(40), fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: Adapt.px(30)),
            SizedBox(
                height: Adapt.px(130),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children:
                      state.streamLinks?.map(_buildStreamLinkCell)?.toList() ??
                          [
                            _buildShimmerLinkCell(),
                            _buildShimmerLinkCell(),
                            _buildShimmerLinkCell()
                          ],
                )),
            SizedBox(height: Adapt.px(30))
          ],
        ),
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
                      color: _theme.primaryColorDark,
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
            Divider()
          ],
        ),
      );
    }

    Widget _buildCommentCell(MovieComment d) {
      var date = DateTime.parse(d.createTime);
      String timeline = TimelineUtil.format(
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
                      image: CachedNetworkImageProvider(d.u.photoUrl ?? ''))),
            ),
            title: Text(d.u.userName),
            subtitle: Text(timeline),
            trailing: Icon(Icons.more_vert),
          ),
          Padding(
            padding: EdgeInsets.only(left: Adapt.px(140), right: Adapt.px(30)),
            child: Text(
              d.comment,
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
                  child: Text(d.like.toString()),
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

    Widget _buildCommentsList() {
      return state.comments == null
          ? SliverToBoxAdapter(
              child: Container(
                  height: Adapt.px(300),
                  child: Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Color(0xFF505050)),
                  ))),
            )
          : state.comments.data.length > 0
              ? SliverList(
                  delegate: SliverChildListDelegate(
                      state.comments.data.map(_buildCommentCell).toList()),
                )
              : SliverToBoxAdapter(
                  child: Container(
                      height: Adapt.px(300),
                      child: Center(
                        child: Image.asset('images/empty_comment.png'),
                      )));
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
  });
}
