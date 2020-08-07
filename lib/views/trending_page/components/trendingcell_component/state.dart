import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/models/search_result.dart';

class TrendingCellState implements Cloneable<TrendingCellState> {
  SearchResult cellData;
  bool liked;
  AppUser user;
  int index;
  TrendingCellState({this.cellData, this.index, this.user, this.liked});
  @override
  TrendingCellState clone() {
    return TrendingCellState()
      ..cellData = cellData
      ..user = user
      ..liked = liked
      ..index = index;
  }
}

TrendingCellState initState(Map<String, dynamic> args) {
  return TrendingCellState();
}
