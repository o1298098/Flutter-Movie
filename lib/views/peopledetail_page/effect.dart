import 'package:fish_redux/fish_redux.dart';
import 'package:movie/actions/apihelper.dart';
import 'action.dart';
import 'state.dart';

Effect<PeopleDetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<PeopleDetailPageState>>{
    PeopleDetailPageAction.action: _onAction,
    Lifecycle.initState:_onInit,
  });
}

void _onAction(Action action, Context<PeopleDetailPageState> ctx) {
}
Future _onInit(Action action, Context<PeopleDetailPageState> ctx) async{
  int id=ctx.state.peopleid;
  var r=await ApiHelper.getPeopleDetail(id);
  if(r!=null)ctx.dispatch(PeopleDetailPageActionCreator.onInit(r));
  var r2=await ApiHelper.getCombinedCredits(id);
  if(r2!=null)ctx.dispatch(PeopleDetailPageActionCreator.onSetCreditModel(r2));

}
