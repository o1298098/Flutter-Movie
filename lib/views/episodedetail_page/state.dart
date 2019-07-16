import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/episodemodel.dart';
import 'package:movie/models/seasondetail.dart';

class EpisodeDetailPageState implements GlobalBaseState<EpisodeDetailPageState> {

Episode episode;
int tvid;

  @override
  EpisodeDetailPageState clone() {
    return EpisodeDetailPageState()
    ..tvid=tvid
    ..episode=episode;
  }

  @override
  Color themeColor;
}

EpisodeDetailPageState initState(Map<String, dynamic> args) {
  EpisodeDetailPageState state=EpisodeDetailPageState() ;
  state.episode=args['episode'];
  state.tvid=args['tvid'];
  return state;
}
