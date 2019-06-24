import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<PeopleDetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<PeopleDetailPageState>>{
    PeopleDetailPageAction.action: _onAction,
  });
}

void _onAction(Action action, Context<PeopleDetailPageState> ctx) {
}
