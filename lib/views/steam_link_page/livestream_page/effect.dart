import 'package:chewie/chewie.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/base_api.dart';
import 'package:movie/customwidgets/custom_video_controls.dart';
import 'package:movie/models/base_api_model/base_user.dart';
import 'package:movie/models/base_api_model/movie_comment.dart';
import 'package:movie/models/base_api_model/movie_stream_link.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'action.dart';
import 'state.dart';

Effect<LiveStreamPageState> buildEffect() {
  return combineEffects(<Object, Effect<LiveStreamPageState>>{
    LiveStreamPageAction.action: _onAction,
    LiveStreamPageAction.chipSelected: _chipSelected,
    LiveStreamPageAction.addComment: _addComment,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<LiveStreamPageState> ctx) {}

void _chipSelected(Action action, Context<LiveStreamPageState> ctx) {
  final MovieStreamLink d = action.payload;
  if (d != null) {
    assert(!d.selected);
    ctx.state.streamLinks.forEach((f) => f.selected = false);
    d.selected = true;

    ctx.state.streamLinkType = d.streamLinkType;
    ctx.dispatch(
        LiveStreamPageActionCreator.setStreamLinks(ctx.state.streamLinks));
    _changedVideoSource(ctx, d);
  }
}

void _addComment(Action action, Context<LiveStreamPageState> ctx) {
  ctx.state.commentController.clear();
  ctx.state.commentFocusNode.unfocus();
  final String comment = action.payload ?? '';
  if (ctx.state.user != null && comment != '') {
    final datetime = DateTime.now().toString();
    final commentModel = MovieComment.fromParams(
        uid: ctx.state.user.uid,
        mediaId: ctx.state.id,
        createTime: datetime,
        updateTime: datetime,
        like: 0,
        u: BaseUser.fromParams(
            uid: ctx.state.user.uid,
            userName: ctx.state.user.displayName,
            photoUrl: ctx.state.user.photoUrl),
        comment: comment);
    ctx.dispatch(LiveStreamPageActionCreator.insertComment(commentModel));
    BaseApi.createMovieComment(commentModel).then((d) {
      ctx.state.comment = null;
      if (d != null) commentModel.id = d.id;
    });
  }
}

void _onInit(Action action, Context<LiveStreamPageState> ctx) {
  ctx.state.commentFocusNode = FocusNode();
  ctx.state.commentController = TextEditingController();
  BaseApi.getMovieStreamLinks(ctx.state.id).then((d) {
    if (d != null) {
      final _list = d.list;
      if (_list.length > 0) {
        ctx.state.videoControllers = _list
            .map((f) => VideoPlayerController.network(f.streamLink))
            .toList();
        _list[0].selected = true;

        ctx.state.streamLinkType = _list[0].streamLinkType;
        ctx.dispatch(LiveStreamPageActionCreator.setStreamLinks(_list));
        _changedVideoSource(ctx, _list[0]);
      }
    }
  });
  BaseApi.getMovieComments(ctx.state.id).then((d) {
    if (d != null) ctx.dispatch(LiveStreamPageActionCreator.setComment(d));
  });
}

void _onDispose(Action action, Context<LiveStreamPageState> ctx) {
  ctx.state.videoControllers.forEach((f) => f.dispose());
  ctx.state.chewieController?.dispose();
  if (ctx.state.youtubePlayerController != null)
    ctx.state.youtubePlayerController.dispose();
}

void _changedVideoSource(
    Context<LiveStreamPageState> ctx, MovieStreamLink d) async {
  int index = ctx.state.streamLinks.indexOf(d);
  if (ctx.state.chewieController != null) {
    ctx.state.chewieController.videoPlayerController
        .seekTo(Duration(seconds: 0));
    ctx.state.chewieController.videoPlayerController.pause();
    ctx.state.chewieController.dispose();
    ctx.state.chewieController = null;
  }
  if (d.streamLinkType.name == 'WebView') {
    ctx.state.streamAddress = d.streamLink;
  } else if (d.streamLinkType.name == 'YouTube') {
    ctx.state.streamAddress = YoutubePlayer.convertUrlToId(d.streamLink);
    ctx.state.chewieController = null;
    if (ctx.state.youtubePlayerController == null)
      ctx.state.youtubePlayerController = new YoutubePlayerController(
        initialVideoId: ctx.state.streamAddress,
        flags: YoutubePlayerFlags(
          autoPlay: true,
        ),
      );
    else {
      ctx.state.youtubePlayerController.load(ctx.state.streamAddress);
    }
  } else {
    await ctx.state.videoControllers[index].initialize();
    ctx.state.chewieController = ChewieController(
        customControls: CustomCupertinoControls(
          backgroundColor: Colors.black,
          iconColor: Colors.white,
        ),
        allowedScreenSleep: false,
        autoPlay: true,
        aspectRatio: ctx.state.videoControllers[index].value.aspectRatio,
        videoPlayerController: ctx.state.videoControllers[index]);
  }

  ctx.dispatch(LiveStreamPageActionCreator.videoPlayerUpdate());
}
