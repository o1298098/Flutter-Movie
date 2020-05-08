import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/user_list.dart';
import 'package:movie/views/listdetail_page/state.dart';

class ShareCardState implements Cloneable<ShareCardState> {
  UserList listDetailModel;
  FirebaseUser user;
  @override
  ShareCardState clone() {
    return ShareCardState();
  }
}

class ShareCardConnector extends ConnOp<ListDetailPageState, ShareCardState> {
  @override
  ShareCardState get(ListDetailPageState state) {
    ShareCardState mstate = ShareCardState();
    mstate.listDetailModel = state.listDetailModel;
    mstate.user = state.user.firebaseUser;
    return mstate;
  }

  @override
  void set(ListDetailPageState state, ShareCardState subState) {}
}
