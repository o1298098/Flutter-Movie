import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action, Page;
import 'package:movie/actions/api/tmdb_api.dart';
import 'package:movie/models/enums/time_window.dart';
import 'package:movie/models/search_result.dart';
import 'package:movie/views/detail_page/page.dart';
import 'package:movie/views/peopledetail_page/page.dart';
import 'package:movie/views/tvshow_detail_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<TrendingPageState> buildEffect() {
  return combineEffects(<Object, Effect<TrendingPageState>>{
    TrendingPageAction.action: _onAction,
    TrendingPageAction.showFilter: _showFilter,
    TrendingPageAction.cellTapped: _cellTapped,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<TrendingPageState> ctx) {}

Future _onInit(Action action, Context<TrendingPageState> ctx) async {
  final Object _ticker = ctx.stfState;
  ctx.state.animationController = AnimationController(
      vsync: _ticker, duration: Duration(milliseconds: 400));
  ctx.state.refreshController = AnimationController(
      vsync: _ticker, duration: Duration(milliseconds: 100));
  ctx.state.controller = ScrollController()
    ..addListener(() {
      if (!ctx.state.animationController.isAnimating) {
        if (ctx.state.animationController.value == 1.0)
          ctx.state.animationController.reverse();
      }
      if (ctx.state.controller.position.pixels ==
          ctx.state.controller.position.maxScrollExtent) _loadMore(ctx);
    });
}

Future _onDispose(Action action, Context<TrendingPageState> ctx) async {
  ctx.state.controller.dispose();
  ctx.state.animationController.dispose();
  ctx.state.refreshController.dispose();
}

Future _showFilter(Action action, Context<TrendingPageState> ctx) async {
  await ctx.state.controller.animateTo(0.0,
      duration: Duration(milliseconds: 300), curve: Curves.ease);
  if (!ctx.state.animationController.isAnimating) {
    if (ctx.state.animationController.value == 0.0)
      ctx.state.animationController.forward();
    else
      ctx.state.animationController.reverse();
  }
}

Future _loadMore(Context<TrendingPageState> ctx) async {
  int _page = ctx.state.trending.page + 1;
  if (_page <= ctx.state.trending.totalPages) {
    final _tmdb = TMDBApi.instance;
    var r = await _tmdb.getTrending(ctx.state.selectMediaType,
        ctx.state.isToday ? TimeWindow.day : TimeWindow.week,
        page: _page);
    if (r.success) ctx.dispatch(TrendingPageActionCreator.loadMore(r.result));
  }
}

Future _cellTapped(Action action, Context<TrendingPageState> ctx) async {
  final SearchResult _d = action.payload;
  String _mediaType = _d.mediaType;
  Page _page;
  var _data;
  switch (_mediaType) {
    case 'movie':
      _page = MovieDetailPage();
      _data = {
        'id': _d.id,
        'bgpic': _d.posterPath,
        'name': _d.title,
        'posterpic': _d.posterPath
      };
      break;
    case 'tv':
      _page = TvShowDetailPage();
      _data = {
        'id': _d.id,
        'bgpic': _d.backdropPath,
        'name': _d.name,
        'posterpic': _d.posterPath
      };
      break;
    case 'person':
      _page = PeopleDetailPage();
      _data = {
        'peopleid': _d.id,
        'profilePath': _d.profilePath,
        'profileName': _d.name,
        'character': ''
      };
      break;
  }
  if (_page != null)
    await Navigator.of(ctx.context).push(PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secAnimation) {
          return FadeTransition(
            opacity: animation,
            child: _page.buildPage(_data),
          );
        }));
}
