import 'package:fish_redux/fish_redux.dart';

enum LastEpisodeAction { action }

class LastEpisodeActionCreator {
  static Action onAction() {
    return const Action(LastEpisodeAction.action);
  }
}
