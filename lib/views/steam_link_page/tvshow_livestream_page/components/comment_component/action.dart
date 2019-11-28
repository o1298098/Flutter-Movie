import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum CommentAction { action }

class CommentActionCreator {
  static Action onAction() {
    return const Action(CommentAction.action);
  }
}
