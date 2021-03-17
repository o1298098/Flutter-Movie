import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/api/tmdb_api.dart';
import 'package:movie/models/enums/media_type.dart';
import 'action.dart';
import 'state.dart';

Effect<PeopleDetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<PeopleDetailPageState>>{
    PeopleDetailPageAction.action: _onAction,
    PeopleDetailPageAction.cellTapped: _cellTapped,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<PeopleDetailPageState> ctx) {}

Future _onInit(Action action, Context<PeopleDetailPageState> ctx) async {
  int id = ctx.state.peopleid;
  await Future.delayed(Duration(milliseconds: 200), () async {
    final _tmdb = TMDBApi.instance;
    final _peopleDetail =
        await _tmdb.getPeopleDetail(id, appendToResponse: 'images');
    if (_peopleDetail.success)
      ctx.dispatch(PeopleDetailPageActionCreator.onInit(_peopleDetail.result));
    var _combinedCredits = await _tmdb.getCombinedCredits(id);
    if (_combinedCredits.success) {
      var cast = [];
      cast = []..addAll(_combinedCredits.result.cast);
      cast.sort((a, b) => b.voteCount.compareTo(a.voteCount));
      _combinedCredits.result.cast = []
        ..addAll(_combinedCredits.result.cast);
      _combinedCredits.result.cast.sort((a, b) {
        String date1 = a.mediaType == 'movie' ? a.releaseDate : a.firstAirDate;
        String date2 = b.mediaType == 'movie' ? b.releaseDate : b.firstAirDate;
        date1 = date1 == null || date1?.isEmpty == true ? '2099-01-01' : date1;
        date2 = date2 == null || date2?.isEmpty == true ? '2099-01-01' : date2;
        DateTime time1 = DateTime.parse(date1);
        DateTime time2 = DateTime.parse(date2);
        return time2.year == time1.year
            ? (time2.month > time1.month ? 1 : -1)
            : (time2.year > time1.year ? 1 : -1);
      });

      var _model = _combinedCredits.result.cast ?? [];
      ctx.state.movies = _model.where((d) => d.mediaType == 'movie').toList();
      ctx.state.tvshows = _model.where((d) => d.mediaType == 'tv').toList();
      ctx.dispatch(PeopleDetailPageActionCreator.onSetCreditModel(
          _combinedCredits.result, cast));
    }
  });
}

void _cellTapped(Action action, Context<PeopleDetailPageState> ctx) async {
  final MediaType type = action.payload[4];
  final int id = action.payload[0];
  final String title = action.payload[2];
  final String posterpic = action.payload[3];
  final String pagename =
      type == MediaType.movie ? 'detailpage' : 'tvShowDetailPage';
  var data = {
    'id': id,
    'bgpic': posterpic,
    'name': title,
    'posterpic': posterpic
  };
  await Navigator.of(ctx.context).pushNamed(pagename, arguments: data);
}
