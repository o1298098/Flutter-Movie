import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<PopularPosterState> buildEffect() {
  return combineEffects(<Object, Effect<PopularPosterState>>{
    PopularPosterAction.action: _onAction,
    PopularPosterAction.cellTapped: _onCellTapped
  });
}

void _onAction(Action action, Context<PopularPosterState> ctx) {}

Future _onCellTapped(Action action, Context<PopularPosterState> ctx) async {
  if (ctx.state.showmovie)
    await Navigator.of(ctx.context).pushNamed('detailpage', arguments: {
      'id': action.payload[0],
      'bgpic': action.payload[3],
      'title': action.payload[2],
      'posterpic': action.payload[3]
    });
  else
    await Navigator.of(ctx.context).pushNamed('tvShowDetailPage', arguments: {
      'tvid': action.payload[0],
      'bgpic': action.payload[1],
      'name': action.payload[2],
      'posterpic': action.payload[3]
    });
}
