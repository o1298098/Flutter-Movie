import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/apihelper.dart';
import 'package:movie/models/episodemodel.dart';
import 'package:movie/models/tvdetail.dart';
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

void _onInit(Action action, Context<SeasonLinkPageState> ctx) {
  final _seasons = ctx.state.detial.seasons.reversed.toList();
  final Object ticker = ctx.stfState;
  ctx.state.tabController = TabController(
      vsync: ticker,
      initialIndex: 0,
      length: ctx.state.detial?.seasons?.length ?? 0)
    ..addListener(() {
      if (!ctx.state.tabController.indexIsChanging) {
        ctx.dispatch(SeasonLinkPageActionCreator.getSeasonDetial(
            _seasons[ctx.state.tabController.index]));
      }
    });
  ctx.state.animationController =
      AnimationController(vsync: ticker, duration: Duration(milliseconds: 400));
  ctx.state.scrollController = ScrollController()
    ..addListener(() {
      if (ctx.state.scrollController.position.pixels > 100 &&
          ctx.state.scrollController.position.pixels <= 150) {
        ctx.state.animationController.value =
            1 - (150 - ctx.state.scrollController.position.pixels) / 50;
      } else if (ctx.state.scrollController.position.pixels > 150 &&
          !ctx.state.animationController.isAnimating)
        ctx.state.animationController.animateTo(1);
      else if (ctx.state.scrollController.position.pixels < 100 &&
          !ctx.state.animationController.isAnimating)
        ctx.state.animationController.animateTo(0);
    });
  if (_seasons != null)
    ctx.dispatch(SeasonLinkPageActionCreator.getSeasonDetial(_seasons[0]));
}

void _onDispose(Action action, Context<SeasonLinkPageState> ctx) {
  ctx.state.animationController.dispose();
  ctx.state.scrollController.dispose();
  ctx.state.tabController.dispose();
}

void _getSeasonDetail(Action action, Context<SeasonLinkPageState> ctx) {
  final Season season = action.payload;
  if (season != null) if (season.episodes == null)
    ApiHelper.getTVSeasonDetail(ctx.state.detial.id, season.seasonNumber,
            appendToResponse: 'credits')
        .then((d) {
      if (d != null) {
        season.episodes = d.episodes;
        season.credits = d.credits;
        ctx.dispatch(
            SeasonLinkPageActionCreator.updateSeason(ctx.state.detial));
      }
    });
}

void _onEpisodeCellTapped(
    Action action, Context<SeasonLinkPageState> ctx) async {
  final _episode = action.payload as Episode;
  await Navigator.of(ctx.context).pushNamed('tvShowLiveStreamPage', arguments: {
    'tvid': ctx.state.detial.id,
    'season': ctx.state.detial.seasons
        .singleWhere((d) => d.seasonNumber == _episode.seasonNumber),
    'episode': _episode,
  });
}
