import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:movie/actions/apihelper.dart';
import 'action.dart';
import 'state.dart';

Effect<SearchBarState> buildEffect() {
  return combineEffects(<Object, Effect<SearchBarState>>{
    SearchBarAction.action: _onAction,
    SearchBarAction.textChanged: _onTextChanged,
  });
}

void _onAction(Action action, Context<SearchBarState> ctx) {}

Future _onTextChanged(Action action, Context<SearchBarState> ctx) async {
  String keyword = action.payload;
  if (keyword != '') {
    var r = await ApiHelper.searchMulit(keyword);
    if (r != null) {
      ctx.dispatch(SearchBarActionCreator.onSetSearchResult(r));
      //FocusScope.of(ctx.context).autofocus(ctx.state.focus);
    }
  }
}
