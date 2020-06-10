import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum LastEpisodeAction { action }

class LastEpisodeActionCreator {
  static Action onAction() {
    return const Action(LastEpisodeAction.action);
  }
}
