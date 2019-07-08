import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum EpisodeDetailPageAction { action }

class EpisodeDetailPageActionCreator {
  static Action onAction() {
    return const Action(EpisodeDetailPageAction.action);
  }
}
