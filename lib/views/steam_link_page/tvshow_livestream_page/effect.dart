import 'package:chewie/chewie.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/http/base_api.dart';
import 'package:movie/widgets/custom_video_controls.dart';
import 'package:movie/widgets/stream_link_report_dialog.dart';
import 'package:movie/models/ad_target_info.dart';
import 'package:movie/models/base_api_model/base_user.dart';
import 'package:movie/models/base_api_model/stream_link_report.dart';
import 'package:movie/models/base_api_model/tvshow_comment.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';
import 'package:movie/models/episodemodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
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
  _rewardedVideoAd.listener =
      (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
    switch (event) {
      case RewardedVideoAdEvent.loaded:
        print('loaded');
        _rewardedVideoAd.show();
        break;
      case RewardedVideoAdEvent.failedToLoad:
        _startPlayer(_streamLink, ctx);
        print('failedToLoad');
        break;
      case RewardedVideoAdEvent.closed:
        if (_isRewarded) {
          _streamLink.needAd = false;
          _startPlayer(_streamLink, ctx);
        }
        ctx.dispatch(TvShowLiveStreamPageActionCreator.loading(false));
        print('closed');
        break;
      case RewardedVideoAdEvent.rewarded:
        _isRewarded = true;
        print('rewarded');
        break;
      default:
        break;
    }
  };
  final _streamLinks = await BaseApi.getTvSeasonStreamLinks(
      ctx.state.tvid, ctx.state.season.seasonNumber);

  if (_streamLinks.success) {
    initVideoPlayer(ctx, _streamLinks.result);
    ctx.dispatch(
        TvShowLiveStreamPageActionCreator.setStreamLinks(_streamLinks.result));
    Future.delayed(
        Duration(milliseconds: 300),
        () => ctx.dispatch(TvShowLiveStreamPageActionCreator.episodeCellTapped(
            _streamLinks.result.list
                .firstWhere((d) => d.episode == ctx.state.episodeNumber))));
  }
}

void _onDispose(Action action, Context<TvShowLiveStreamPageState> ctx) {
  ctx.state.episodelistController.dispose();
  ctx.state.tabController.dispose();
  ctx.state.commentController.dispose();
  ctx.state.chewieController?.dispose();
  ctx.state.youtubePlayerController?.dispose();
  ctx.state.videoControllers?.forEach((f) => f.dispose());
}

void _addComment(Action action, Context<TvShowLiveStreamPageState> ctx) async {
  final String _commentTxt = action.payload;
  if (ctx.state.user == null) {
    Toast.show('login before comment', ctx.context, duration: 2);
    return;
  }
  if (_commentTxt != '' && _commentTxt != null) {
    final String _date = DateTime.now().toString();
    final TvShowComment _comment = TvShowComment.fromParams(
        mediaId: ctx.state.tvid,
        comment: _commentTxt,
        uid: ctx.state.user.firebaseUser.uid,
        updateTime: _date,
        createTime: _date,
        season: ctx.state.season.seasonNumber,
        episode: ctx.state.episodeNumber,
        u: BaseUser.fromParams(
            uid: ctx.state.user.firebaseUser.uid,
            userName: ctx.state.user.firebaseUser.displayName,
            photoUrl: ctx.state.user.firebaseUser.photoUrl),
        like: 0);
    ctx.state.commentController.clear();
    ctx.dispatch(TvShowLiveStreamPageActionCreator.insertComment(_comment));
    BaseApi.createTvShowComment(_comment).then((r) {
      if (r.success) _comment.id = r.result.id;
    });
  }
}

final _rewardedVideoAd = RewardedVideoAd.instance;
bool _isRewarded = false;

TvShowStreamLink _streamLink;
void _episodeCellTapped(
    Action action, Context<TvShowLiveStreamPageState> ctx) async {
  final TvShowStreamLink e = action.payload;
  if (e != null) {
    if (e.needAd && !(ctx.state.user?.isPremium ?? false)) {
      ctx.dispatch(TvShowLiveStreamPageActionCreator.loading(true));
      _streamLink = e;
      _rewardedVideoAd.load(
          adUnitId: RewardedVideoAd.testAdUnitId,
          targetingInfo: AdTargetInfo.targetingInfo);
    } else
      await _startPlayer(e, ctx);
  }
}

Future _startPlayer(
    TvShowStreamLink link, Context<TvShowLiveStreamPageState> ctx) async {
  final Episode episode = ctx.state.season.episodes
      .singleWhere((d) => d.episodeNumber == link.episode);
  if (!episode.playState) {
    final index = ctx.state.season.episodes.indexOf(episode);
    episode.playState = true;
    ctx.state.season.playStates[index] = '1';
    ctx.state.preferences.setStringList(
        'TvSeason${ctx.state.season.id}', ctx.state.season.playStates);
  }

  ctx.dispatch(TvShowLiveStreamPageActionCreator.episodeChanged(episode, link));
  final _scrollIndex = ctx.state.streamLinks.list.indexOf(link);
  await ctx.state.episodelistController.animateTo(Adapt.px(330) * _scrollIndex,
      curve: Curves.ease, duration: Duration(milliseconds: 300));

  videoSourceChange(ctx, link);

  final comment = await BaseApi.getTvShowComments(
      ctx.state.tvid, ctx.state.season.seasonNumber, link.episode);

  if (comment.success)
    ctx.dispatch(TvShowLiveStreamPageActionCreator.setComments(comment.result));
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
    },
  );
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
    await ctx.state.chewieController.videoPlayerController
        .seekTo(Duration(seconds: 0));
    await ctx.state.chewieController.videoPlayerController.pause();
    ctx.state.chewieController?.dispose();
    ctx.state.chewieController = null;
  }

  ctx.state.streamLinkType = d.streamLinkType;
  if (d.streamLinkType.name == 'WebView' ||
      d.streamLinkType.name == 'Torrent') {
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
