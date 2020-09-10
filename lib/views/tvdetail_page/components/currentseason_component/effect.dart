import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart'hide Action;
import 'package:movie/views/seasons_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<CurrentSeasonState> buildEffect() {
  return combineEffects(<Object, Effect<CurrentSeasonState>>{
    CurrentSeasonAction.action: _onAction,
    CurrentSeasonAction.cellTapped:_onCellTapped,
    CurrentSeasonAction.allSeasonsTapped:_allSeasonsTapped
  });
}

void _onAction(Action action, Context<CurrentSeasonState> ctx) {
}

Future _onCellTapped(Action action, Context<CurrentSeasonState> ctx) async{
  await Navigator.of(ctx.context).pushNamed('seasondetailpage',arguments: {'tvid':action.payload[0],'seasonNumber':action.payload[1],'name':action.payload[2],'posterpic':action.payload[3]});
}
Future _allSeasonsTapped(Action action, Context<CurrentSeasonState> ctx) async{
  await Navigator.of(ctx.context).push(PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return new FadeTransition(
            opacity: animation,
            child: SeasonsPage().buildPage({
              'tvid':action.payload[0],
              'list':action.payload[1]
            }));
      }));
  //await Navigator.of(ctx.context).pushNamed('SeasonsPage',arguments: {'tvid':action.payload[0],'list':action.payload[1]});
}
