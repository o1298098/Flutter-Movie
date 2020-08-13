import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:movie/views/stream_link/episode_livestream_page/page.dart';
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
              {'selectedEpisode': action.payload, 'season': ctx.state.episodes},
            ),
          ),
        );
      },
    ),
  );
}
