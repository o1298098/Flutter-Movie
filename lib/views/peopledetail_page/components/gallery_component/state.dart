import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/people_detail.dart';
import 'package:movie/views/peopledetail_page/state.dart';

class GalleryState implements Cloneable<GalleryState> {
  ProfileImages images;
  GalleryState({this.images});

  @override
  GalleryState clone() {
    return GalleryState();
  }
}

class GalleryConnector extends ConnOp<PeopleDetailPageState, GalleryState> {
  @override
  GalleryState get(PeopleDetailPageState state) {
    GalleryState mstate = GalleryState();
    mstate.images = state.peopleDetailModel.images;
    return mstate;
  }
}
