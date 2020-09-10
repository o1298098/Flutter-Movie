import 'package:fish_redux/fish_redux.dart';

enum PopularPosterAction {
  action,
  cellTapped,
  popularFilterChanged,
}

class PopularPosterActionCreator {
  static Action onAction() {
    return const Action(PopularPosterAction.action);
  }

  static Action onCellTapped(
      int id, String bgpic, String title, String posterpic) {
    return Action(PopularPosterAction.cellTapped,
        payload: [id, bgpic, title, posterpic]);
  }

  static Action onPopularFilterChanged(bool e) {
    return Action(PopularPosterAction.popularFilterChanged, payload: e);
  }
}
