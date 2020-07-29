import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/tvshow_detail.dart';
import 'package:movie/views/tvshow_detail_page/state.dart';

class TitleState implements Cloneable<TitleState> {
  String name;
  List<Genre> genres;
  double vote;
  ContentRatingModel contentRatings;
  String overview;
  TitleState();
  @override
  TitleState clone() {
    return TitleState()
      ..name = name
      ..genres = genres
      ..vote = vote
      ..contentRatings = contentRatings
      ..overview = overview;
  }
}

class TitleConnector extends ConnOp<TvShowDetailState, TitleState> {
  @override
  TitleState get(TvShowDetailState state) {
    TitleState substate = TitleState();
    substate.name = state.tvDetailModel?.name;
    substate.contentRatings = state.tvDetailModel?.contentRatings;
    substate.genres = state.tvDetailModel?.genres;
    substate.vote = state.tvDetailModel?.voteAverage;
    substate.overview = state.tvDetailModel?.overview;
    return substate;
  }
}
