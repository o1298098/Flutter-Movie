import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/sort_condition.dart';

enum FilterAction {
  action,
  sortChanged,
  genresChanged,
  updateGenres,
  keywordschanged,
  mediaTypeChange,
  dataSortChange,
  votefilterChange,
  applyFilter
}

class FilterActionCreator {
  static Action onAction() {
    return const Action(FilterAction.action);
  }

  static Action onSortChanged(SortCondition sort) {
    return Action(FilterAction.sortChanged, payload: sort);
  }

  static Action onGenresChanged(SortCondition genre) {
    return Action(FilterAction.genresChanged, payload: genre);
  }

  static Action onKeyWordsChanged(String s) {
    return Action(FilterAction.keywordschanged, payload: s);
  }

  static Action mediaTypeChange(bool isMovie) {
    return Action(FilterAction.mediaTypeChange, payload: isMovie);
  }

  static Action dataSortChange(bool desc) {
    return Action(FilterAction.dataSortChange, payload: desc);
  }

  static Action updateGenres(List<SortCondition> genres) {
    return Action(FilterAction.updateGenres, payload: genres);
  }

  static Action votefilterChange(double lvote, double rvote) {
    return Action(FilterAction.votefilterChange, payload: [lvote, rvote]);
  }

  static Action applyFilter() {
    return const Action(FilterAction.applyFilter);
  }
}
