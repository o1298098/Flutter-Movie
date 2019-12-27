import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/base_movie.dart';
import 'package:movie/models/base_api_model/base_tvshow.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/searchresult.dart';
import 'package:movie/models/videolist.dart';

enum HomePageAction {
  action,
  initMovie,
  initTV,
  initPopularMovies,
  initPopularTVShows,
  popularFilterChanged,
  headerFilterChanged,
  shareFilterChanged,
  moreTapped,
  initTrending,
  searchBarTapped,
  cellTapped,
  trendingMore,
  shareMore,
  initShareMovies,
  initShareTvShows,
}

class HomePageActionCreator {
  static Action onAction() {
    return const Action(HomePageAction.action);
  }

  static Action onInitMovie(VideoListModel movie) {
    return Action(HomePageAction.initMovie, payload: movie);
  }

  static Action onInitTV(VideoListModel tv) {
    return Action(HomePageAction.initTV, payload: tv);
  }

  static Action onInitPopularMovie(VideoListModel pop) {
    return Action(HomePageAction.initPopularMovies, payload: pop);
  }

  static Action onInitPopularTV(VideoListModel pop) {
    return Action(HomePageAction.initPopularTVShows, payload: pop);
  }

  static Action onPopularFilterChanged(bool e) {
    return Action(HomePageAction.popularFilterChanged, payload: e);
  }

  static Action onHeaderFilterChanged(bool e) {
    return Action(HomePageAction.headerFilterChanged, payload: e);
  }

  static Action onShareFilterChanged(bool e) {
    return Action(HomePageAction.shareFilterChanged, payload: e);
  }

  static Action onMoreTapped(VideoListModel model, MediaType t) {
    return Action(HomePageAction.moreTapped, payload: [model, t]);
  }

  static Action initTrending(SearchResultModel d) {
    return Action(HomePageAction.initTrending, payload: d);
  }

  static Action onSearchBarTapped() {
    return const Action(HomePageAction.searchBarTapped);
  }

  static Action onCellTapped(
      int id, String bgpic, String title, String posterpic, MediaType type) {
    return Action(HomePageAction.cellTapped,
        payload: [id, bgpic, title, posterpic, type]);
  }

  static Action onTrendingMore() {
    return const Action(HomePageAction.trendingMore);
  }

  static Action onShareMore() {
    return const Action(HomePageAction.shareMore);
  }

  static Action initShareMovies(BaseMovieModel d) {
    return Action(HomePageAction.initShareMovies, payload: d);
  }

  static Action initShareTvShows(BaseTvShowModel d) {
    return Action(HomePageAction.initShareTvShows, payload: d);
  }
}
