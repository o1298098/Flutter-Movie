import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ReviewAction { action }

class ReviewActionCreator {
  static Action onAction() {
    return const Action(ReviewAction.action);
  }
}
