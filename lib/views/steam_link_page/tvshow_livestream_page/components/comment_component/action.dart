import 'package:fish_redux/fish_redux.dart';

enum CommentAction { action }

class CommentActionCreator {
  static Action onAction() {
    return const Action(CommentAction.action);
  }
}
