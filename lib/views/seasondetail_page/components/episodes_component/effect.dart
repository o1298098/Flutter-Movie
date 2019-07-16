import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:movie/views/episodedetail_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<EpisodesState> buildEffect() {
  return combineEffects(<Object, Effect<EpisodesState>>{
    EpisodesAction.action: _onAction,
    Lifecycle.initState: _onInit,
    EpisodesAction.cellTapped: _onCellTapped
  });
}

void _onAction(Action action, Context<EpisodesState> ctx) {}
void _onInit(Action action, Context<EpisodesState> ctx) {}
Future _onCellTapped(Action action, Context<EpisodesState> ctx) async {
  await Navigator.of(ctx.context).push(PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return new FadeTransition(
            opacity: animation,
            child: EpisodeDetailPage().buildPage({
              'tvid': ctx.state.tvid,
              'episode': action.payload
            }));
            /*SlideTransition(
          position: Tween<Offset>(
            begin: Offset.zero,
            end: Offset.zero,
          ).animate(animation),
          child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset.zero,
                end: Offset.zero,
              ).animate(secondaryAnimation),
              child: EpisodeDetailPage().buildPage(
                  {'tvid': ctx.state.tvid, 'episode': action.payload})),
        );*/
      }));
  /*await Navigator.of(ctx.context).pushNamed('episodedetailpage', arguments: {
    'tvid': ctx.state.tvid,
    'seasonnum': action.payload[0],
    'episodenum': action.payload[1]
  });*/
}
