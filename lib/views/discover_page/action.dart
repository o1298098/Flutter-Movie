import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum DiscoverPageAction { action }

class DiscoverPageActionCreator {
  static Action onAction() {
    return const Action(DiscoverPageAction.action);
  }
}
