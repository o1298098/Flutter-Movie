import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/widgets.dart' hide Action;
import 'package:movie/customwidgets/searchbar_delegate.dart';
import 'package:movie/views/search_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<SearchBarState> buildEffect() {
  return combineEffects(<Object, Effect<SearchBarState>>{
    SearchBarAction.action: _onAction,
    SearchBarAction.searchBarTapped: _onSearchBarTapped,
  });
}

void _onAction(Action action, Context<SearchBarState> ctx) {}
Future _onSearchBarTapped(Action action, Context<SearchBarState> ctx) async {
  showSearch(context: ctx.context, delegate: SearchBarDelegate());
  //await Navigator.of(ctx.context).pushNamed('searchpage');
  /*await Navigator.of(ctx.context).push(PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return new FadeTransition(
            opacity: animation, child: SearchPage().buildPage({}));
      }));*/
}
