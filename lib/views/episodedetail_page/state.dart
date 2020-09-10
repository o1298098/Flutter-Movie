import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/episode_model.dart';
import 'package:movie/models/app_user.dart';

import 'components/credits_component/state.dart';
import 'components/header_component/state.dart';
import 'components/images_component/state.dart';

class EpisodeDetailPageState extends MutableSource
    implements GlobalBaseState, Cloneable<EpisodeDetailPageState> {
  Episode episode;
  int tvid;

  @override
  EpisodeDetailPageState clone() {
    return EpisodeDetailPageState()
      ..tvid = tvid
      ..episode = episode;
  }

  @override
  Color themeColor;

  @override
  Locale locale;

  @override
  AppUser user;

  @override
  Object getItemData(int index) {
    switch (index) {
      case 0:
        return EpisodeHeaderState(episode: episode);
      case 1:
        return CreditsState(
            guestStars: episode?.credits?.guestStars,
            crew: episode?.credits?.crew);
      case 2:
        return ImagesState(images: episode?.images);
      default:
        return null;
    }
  }

  @override
  String getItemType(int index) {
    switch (index) {
      case 0:
        return 'header';
      case 1:
        return 'credits';
      case 2:
        return 'images';
      default:
        return null;
    }
  }

  @override
  int get itemCount => 3;

  @override
  void setItemData(int index, Object data) {}
}

EpisodeDetailPageState initState(Map<String, dynamic> args) {
  EpisodeDetailPageState state = EpisodeDetailPageState();
  state.episode = args['episode'];
  state.tvid = args['tvid'];
  return state;
}
