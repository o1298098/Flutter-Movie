import 'package:fish_redux/fish_redux.dart';

enum EpisodeHeaderAction { action }

class EpisodeHeaderActionCreator {
  static Action onAction() {
    return const Action(EpisodeHeaderAction.action);
  }
}
