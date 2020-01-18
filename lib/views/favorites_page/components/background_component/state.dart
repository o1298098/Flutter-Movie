import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/favorites_page/state.dart';

class BackGroundState implements Cloneable<BackGroundState> {
  String photoUrl;
  @override
  BackGroundState clone() {
    return BackGroundState();
  }
}

class BackGroundConnector extends ConnOp<FavoritesPageState, BackGroundState> {
  @override
  BackGroundState get(FavoritesPageState state) {
    final BackGroundState mstate = BackGroundState();
    mstate.photoUrl = state.selectedMedia?.photoUrl ?? '';
    return mstate;
  }
}
