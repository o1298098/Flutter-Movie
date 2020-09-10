import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/episode_model.dart';

class ImagesState implements Cloneable<ImagesState> {
  EpisodeImageModel images;

  ImagesState({this.images});

  @override
  ImagesState clone() {
    return ImagesState();
  }
}

ImagesState initState(Map<String, dynamic> args) {
  return ImagesState();
}
