import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/api/tmdb_api.dart';
import 'package:movie/actions/api/base_api.dart';
import 'package:movie/models/episode_model.dart';
import 'package:movie/models/season_detail.dart';
import 'package:movie/views/stream_link/episode_livestream_page/page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<SeasonLinkPageState> buildEffect() {
  return combineEffects(<Object, Effect<SeasonLinkPageState>>{
    SeasonLinkPageAction.action: _onAction,
    SeasonLinkPageAction.getSeasonDetial: _getSeasonDetail,
    SeasonLinkPageAction.episodeCellTapped: _onEpisodeCellTapped,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<SeasonLinkPageState> ctx) {}

void _onInit(Action action, Context<SeasonLinkPageState> ctx) async {
  final _seasons = ctx.state.detail.seasons.reversed.toList();
  final Object ticker = ctx.stfState;
  ctx.state.tabController = TabController(
      vsync: ticker,
      initialIndex: 0,
      length: ctx.state.detail?.seasons?.length ?? 0)
    ..addListener(() {
      if (!ctx.state.tabController.indexIsChanging) {
        ctx.dispatch(SeasonLinkPageActionCreator.getSeasonDetial(
            _seasons[ctx.state.tabController.index]));
      }
    });
  ctx.state.animationController =
      AnimationController(vsync: ticker, duration: Duration(milliseconds: 300));
  ctx.state.scrollController = ScrollController()
    ..addListener(() {
      if (ctx.state.scrollController.position.pixels >= 100 &&
          !ctx.state.animationController.isAnimating)
        ctx.state.animationController.animateTo(1, curve: Curves.ease);
      else if (ctx.state.scrollController.position.pixels < 100 &&
          !ctx.state.animationController.isAnimating)
        ctx.state.animationController.animateTo(0, curve: Curves.ease);
    });
  ctx.state.preferences = await SharedPreferences.getInstance();
  if (_seasons != null)
    ctx.dispatch(SeasonLinkPageActionCreator.getSeasonDetial(_seasons[0]));
}

void _onDispose(Action action, Context<SeasonLinkPageState> ctx) {
  ctx.state.animationController.dispose();
  ctx.state.scrollController.dispose();
  ctx.state.tabController.dispose();
}

void _getSeasonDetail(Action action, Context<SeasonLinkPageState> ctx) async {
  final Season season = action.payload;
  if (season != null && season?.episodes == null) {
    final _tmdb = TMDBApi.instance;
    final _episode = await _tmdb.getTVSeasonDetail(
        ctx.state.detail.id, season.seasonNumber,
        appendToResponse: 'credits');
    if (_episode.success) {
      List<String> _playState =
          ctx.state.preferences.getStringList('TvSeason${season.id}');
      season.playStates =
          _playState ?? _episode.result.episodes.map((f) => '0').toList();
      season.episodes = _episode.result.episodes;
      season.credits = _episode.result.credits;

      final _baseApi = BaseApi.instance;
      final _streamLinks = await _baseApi.getTvSeasonStreamLinks(
          ctx.state.detail.id, season.seasonNumber);
      if (_streamLinks.success)
        season.episodes.forEach((f) {
          final index = season.episodes.indexOf(f);
          f.streamLink = _streamLinks.result.list.firstWhere((d) {
            return d.episode == f.episodeNumber;
          }, orElse: () => null);
          f.playState = season.playStates[index] == '0' ? false : true;
        });
      ctx.dispatch(SeasonLinkPageActionCreator.updateSeason(ctx.state.detail));
    }
  }
}

void _onEpisodeCellTapped(
    Action action, Context<SeasonLinkPageState> ctx) async {
  final _episode = action.payload as Episode;
  if (_episode.streamLink != null) {
    Season _season = ctx.state.detail.seasons.singleWhere(
        (s) => s.seasonNumber == _episode.seasonNumber,
        orElse: () => null);
    if (_season == null) return;
    final index = _season.episodes.indexOf(_episode);
    if (_season.playStates[index] != '1') {
      _season.playStates[index] = '1';
      _episode.playState = true;
      ctx.state.preferences
          .setStringList('TvSeason${_season.id}', _season.playStates)
          .then((d) {
        if (d)
          ctx.dispatch(
              SeasonLinkPageActionCreator.updateSeason(ctx.state.detail));
      });
    }
    await Navigator.of(ctx.context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          final _curvedAnimation =
              CurvedAnimation(parent: animation, curve: Curves.ease);
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, 1),
              end: Offset.zero,
            ).animate(_curvedAnimation),
            child: FadeTransition(
              opacity: _curvedAnimation,
              child: EpisodeLiveStreamPage().buildPage(
                {
                  'tvid': ctx.state.detail.id,
                  'selectedEpisode': _episode,
                  'season': _season
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
