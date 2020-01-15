import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SwiperAction { action }

class SwiperActionCreator {
  static Action onAction() {
    return const Action(SwiperAction.action);
  }
}
