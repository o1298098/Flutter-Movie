import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/sort_condition.dart';
import 'package:movie/views/listdetail_page/state.dart';

class HeaderState implements Cloneable<HeaderState> {
  int listid;
  String backGroundUrl;
  String description;
  List<SortCondition> sortBy;
  String sortType;
  FirebaseUser user;
  @override
  HeaderState clone() {
    return HeaderState();
  }
}

class HeaderConnector extends ConnOp<ListDetailPageState, HeaderState> {
  @override
  HeaderState get(ListDetailPageState state) {
    HeaderState mstate = HeaderState();
    mstate.listid = state.listDetailModel.id;
    mstate.backGroundUrl = state.listDetailModel?.backGroundUrl ?? '';
    mstate.description = state.listDetailModel?.description ?? '';
    mstate.sortBy = state.sortBy;
    mstate.sortType = state.sortType;
    mstate.user = state.user.firebaseUser;
    return mstate;
  }

  @override
  void set(ListDetailPageState state, HeaderState subState) {}
}
