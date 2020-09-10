import 'package:fish_redux/fish_redux.dart';

enum KnownForAction { action }

class KnownForActionCreator {
  static Action onAction() {
    return const Action(KnownForAction.action);
  }
}
