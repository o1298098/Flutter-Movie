import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/imagemodel.dart';

class GalleryPageState implements Cloneable<GalleryPageState> {
  List<ImageData> images;

  @override
  GalleryPageState clone() {
    return GalleryPageState()..images = images;
  }
}

GalleryPageState initState(Map<String, dynamic> args) {
  GalleryPageState state = GalleryPageState();
  state.images = args['images'];
  return state;
}
