import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/user_list_detail.dart';

class ListCellState implements Cloneable<ListCellState> {
  UserListDetail cellData;
  ListCellState({this.cellData});
  @override
  ListCellState clone() {
    return ListCellState()..cellData = cellData;
  }
}

ListCellState initState(Map<String, dynamic> args) {
  return ListCellState();
}
