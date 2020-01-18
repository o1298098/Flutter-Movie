import 'package:fish_redux/fish_redux.dart';

enum RecommendationsAction { action }

class RecommendationsActionCreator {
  static Action onAction() {
    return const Action(RecommendationsAction.action);
  }
}
