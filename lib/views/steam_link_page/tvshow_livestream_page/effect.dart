import 'package:chewie/chewie.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/base_api.dart';
import 'package:movie/customwidgets/custom_video_controls.dart';
import 'package:movie/customwidgets/stream_link_report_dialog.dart';
import 'package:movie/models/base_api_model/base_user.dart';
import 'package:movie/models/base_api_model/stream_link_report.dart';
import 'package:movie/models/base_api_model/tvshow_comment.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';
import 'package:movie/models/episodemodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'action.dart';
import 'state.dart';

Effect<TvShowLiveStreamPageState> buildEffect() {
  return combineEffects(<Object, Effect<TvShowLiveStreamPageState>>{
    TvShowLiveStreamPageAction.action: _onAction,
    TvShowLiveStreamPageAction.episodeCellTapped: _episodeCellTapped,
    TvShowLiveStreamPageAction.addComment: _addComment,
    TvShowLiveStreamPageAction.episodesMoreTapped: _episodesMoreTapped,
    TvShowLiveStreamPageAction.streamLinkReport: _streamLinkReport,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<TvShowLiveStreamPageState> ctx) {}

void _onInit(Action action, Context<TvShowLiveStreamPageState> ctx) async {
  final Object ticker = ctx.stfState;
  ctx.state.episodelistController = ScrollController();
  ctx.state.commentController = TextEditingController();
  ctx.state.tabController = TabController(vsync: ticker, length: 2)
    ..addListener(() {
      if (ctx.state.tabController.index == 1)
        ctx.dispatch(TvShowLiveStreamPageActionCreator.onShowBottom(true));
      else
        ctx.dispatch(TvShowLiveStreamPageActionCreator.onShowBottom(false));
    });
  ctx.state.preferences = await SharedPreferences.getInstance();
  final _streamLinks = await BaseApi.getTvSeasonStreamLinks(
      ctx.state.tvid, ctx.state.season.seasonNumber);
  if (_streamLinks != null) {
    initVideoPlayer(ctx, _streamLinks);
    ctx.dispatch(
        TvShowLiveStreamPageActionCreator.setStreamLinks(_streamLinks));
    ctx.dispatch(TvShowLiveStreamPageActionCreator.episodeCellTapped(
        _streamLinks.list
            .singleWhere((d) => d.episode == ctx.state.episodeNumber)));
  }
}

void _onDispose(Action action, Context<TvShowLiveStreamPageState> ctx) {
  ctx.state.episodelistController.dispose();
  ctx.state.tabController.dispose();
  ctx.state.commentController.dispose();
  ctx.state.chewieController?.dispose();
  ctx.state.youtubePlayerController?.dispose();
  ctx.state.videoControllers.forEach((f) => f.dispose());
}

void _addComment(Action action, Context<TvShowLiveStreamPageState> ctx) async {
  final String _commentTxt = action.payload;
  if (_commentTxt != '' && _commentTxt != null && ctx.state.user != null) {
    final String _date = DateTime.now().toString();
    final TvShowComment _comment = TvShowComment.fromParams(
        mediaId: ctx.state.tvid,
        comment: _commentTxt,
        uid: ctx.state.user.uid,
        updateTime: _date,
        createTime: _date,
        season: ctx.state.season.seasonNumber,
        episode: ctx.state.episodeNumber,
        u: BaseUser.fromParams(
            uid: ctx.state.user.uid,
            userName: ctx.state.user.displayName,
            photoUrl: ctx.state.user.photoUrl),
        like: 0);
    ctx.state.commentController.clear();
    ctx.dispatch(TvShowLiveStreamPageActionCreator.insertComment(_comment));
    BaseApi.createTvShowComment(_comment).then((r) {
      if (r != null) _comment.id = r.id;
      print(ctx.state.comments.data);
    });
  }
}

void _episodeCellTapped(
    Action action, Context<TvShowLiveStreamPageState> ctx) async {
  final TvShowStreamLink e = action.payload;
  if (e != null) {
    final Episode episode = ctx.state.season.episodes
        .singleWhere((d) => d.episodeNumber == e.episode);
    if (!episode.playState) {
      final index = ctx.state.season.episodes.indexOf(episode);
      episode.playState = true;
      ctx.state.season.playStates[index] = '1';
      ctx.state.preferences.setStringList(
          'TvSeason${ctx.state.season.id}', ctx.state.season.playStates);
    }
    ctx.dispatch(TvShowLiveStreamPageActionCreator.episodeChanged(episode));

    await ctx.state.episodelistController.animateTo(
        Adapt.px(330) * (e.episode - 1),
        curve: Curves.ease,
        duration: Duration(milliseconds: 300));

    videoSourceChange(ctx, e);

    final comment = await BaseApi.getTvShowComments(
        ctx.state.tvid, ctx.state.season.seasonNumber, e.episode);

    if (comment != null)
      ctx.dispatch(TvShowLiveStreamPageActionCreator.setComments(comment));
  }
}

void _streamLinkReport(Action action, Context<TvShowLiveStreamPageState> ctx) {
  final TvShowStreamLink e = ctx.state.streamLinks.list
      .singleWhere((d) => d.episode == ctx.state.episodeNumber);
  showDialog(
      context: ctx.context,
      builder: (_) {
        return StreamLinkReportDialog(
          report: StreamLinkReport(
            mediaId: ctx.state.tvid,
            mediaName: ctx.state.mediaName,
            linkName: ctx.state.season.name + "  " + e?.linkName,
            streamLink: e.streamLink,
            type: "tv",
            streamLinkId: e.sid,
          ),
        );
      });
}

void _episodesMoreTapped(
    Action action, Context<TvShowLiveStreamPageState> ctx) async {
  await Navigator.push(
      ctx.context,
      PageRouteBuilder(
          opaque: false,
          barrierLabel: '',
          barrierColor: Colors.black.withOpacity(0.8),
          barrierDismissible: true,
          fullscreenDialog: false,
          maintainState: true,
          transitionDuration: Duration(milliseconds: 300),
          transitionsBuilder: (_, animation, ___, widget) {
            return SlideTransition(
              position: Tween(begin: Offset(0, 1), end: Offset(0, .3)).animate(
                  CurvedAnimation(parent: animation, curve: Curves.ease)),
              child: widget,
            );
          },
          pageBuilder: (_, animation, ___) {
            return Material(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: Adapt.px(30)),
                child: action.payload,
              ),
            );
          }));
}

void initVideoPlayer(
    Context<TvShowLiveStreamPageState> ctx, TvShowStreamLinks streamLinks) {
  final _list = streamLinks.list;
  if (_list.length > 0) {
    ctx.state.videoControllers =
        _list.map((f) => VideoPlayerController.network(f.streamLink)).toList();
  }
}

Future videoSourceChange(
    Context<TvShowLiveStreamPageState> ctx, TvShowStreamLink d) async {
  int index = ctx.state.streamLinks.list.indexOf(d);
  if (ctx.state.chewieController != null) {
    ctx.state.chewieController?.dispose();
    ctx.state.chewieController.videoPlayerController
        .seekTo(Duration(seconds: 0));
    ctx.state.chewieController.videoPlayerController.pause();
    ctx.state.chewieController = null;
  }

  ctx.state.streamLinkType = d.streamLinkType;
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
        autoInitialize: true,
        autoPlay: true,
        aspectRatio: ctx.state.videoControllers[index].value.aspectRatio,
        videoPlayerController: ctx.state.videoControllers[index]);
  }
  ctx.dispatch(
      TvShowLiveStreamPageActionCreator.setStreamLinks(ctx.state.streamLinks));
}
