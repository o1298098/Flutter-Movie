import 'package:fish_redux/fish_redux.dart';
import 'package:movie/actions/apihelper.dart';
import 'package:movie/models/combinedcredits.dart';
import 'action.dart';
import 'state.dart';

Effect<PeopleDetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<PeopleDetailPageState>>{
    PeopleDetailPageAction.action: _onAction,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<PeopleDetailPageState> ctx) {}
Future _onInit(Action action, Context<PeopleDetailPageState> ctx) async {
  int id = ctx.state.peopleid;
  await Future.delayed(Duration(milliseconds: 200), () async {
    var r = await ApiHelper.getPeopleDetail(id);
    if (r != null) ctx.dispatch(PeopleDetailPageActionCreator.onInit(r));
    var r2 = await ApiHelper.getCombinedCredits(id);
    if (r2 != null) {
      var cast = List<CastData>();
      cast = new List<CastData>()..addAll(r2.cast);
      cast.sort((a, b) => b.vote_count.compareTo(a.vote_count));
      r2.cast = new List<CastData>()..addAll(r2.cast);
      r2.cast.sort((a, b) {
        String date1 =
            a.media_type == 'movie' ? a.release_date : a.first_air_date;
        String date2 =
            b.media_type == 'movie' ? b.release_date : b.first_air_date;
        date1 = date1 == null || date1?.isEmpty == true ? '2099-01-01' : date1;
        date2 = date2 == null || date2?.isEmpty == true ? '2099-01-01' : date2;
        DateTime time1 = DateTime.parse(date1);
        DateTime time2 = DateTime.parse(date2);
        return time2.year == time1.year
            ? (time2.month > time1.month ? 1 : -1)
            : (time2.year > time1.year ? 1 : -1);
      });
      ctx.dispatch(PeopleDetailPageActionCreator.onSetCreditModel(r2, cast));
    }
  });
}
