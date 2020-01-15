import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum RecommendationsAction { action }

class RecommendationsActionCreator {
  static Action onAction() {
    return const Action(RecommendationsAction.action);
  }
}
