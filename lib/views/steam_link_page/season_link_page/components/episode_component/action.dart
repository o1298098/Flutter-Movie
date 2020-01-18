import 'package:fish_redux/fish_redux.dart';

enum EpisodeAction { action }

class EpisodeActionCreator {
  static Action onAction() {
    return const Action(EpisodeAction.action);
  }
}
