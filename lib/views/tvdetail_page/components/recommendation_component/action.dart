import 'package:fish_redux/fish_redux.dart';

enum RecommendationAction { action }

class RecommendationActionCreator {
  static Action onAction() {
    return const Action(RecommendationAction.action);
  }
}
