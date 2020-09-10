import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/image_model.dart';
import 'package:movie/views/tvdetail_page/state.dart';

class ImagesState implements Cloneable<ImagesState> {
  List<ImageData> backdrops;
  List<ImageData> posters;
  @override
  ImagesState clone() {
    return ImagesState();
  }
}

class ImagesConnector extends ConnOp<TVDetailPageState, ImagesState> {
  @override
  ImagesState get(TVDetailPageState state) {
    ImagesState mstate = ImagesState();
    mstate.backdrops = state.imagesmodel.backdrops;
    mstate.posters = state.imagesmodel.posters;
    return mstate;
  }
}
