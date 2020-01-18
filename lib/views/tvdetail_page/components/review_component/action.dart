import 'package:fish_redux/fish_redux.dart';

enum ReviewAction { action }

class ReviewActionCreator {
  static Action onAction() {
    return const Action(ReviewAction.action);
  }
}
