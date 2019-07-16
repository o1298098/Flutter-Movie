import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum EpisodeHeaderAction { action }

class EpisodeHeaderActionCreator {
  static Action onAction() {
    return const Action(EpisodeHeaderAction.action);
  }
}
