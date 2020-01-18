import 'package:fish_redux/fish_redux.dart';

enum ShareCardAction { action }

class ShareCardActionCreator {
  static Action onAction() {
    return const Action(ShareCardAction.action);
  }
}
