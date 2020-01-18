import 'package:fish_redux/fish_redux.dart';

enum SwiperAction { action }

class SwiperActionCreator {
  static Action onAction() {
    return const Action(SwiperAction.action);
  }
}
