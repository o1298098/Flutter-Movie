import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ShareAction { action }

class ShareActionCreator {
  static Action onAction() {
    return const Action(ShareAction.action);
  }
}
