import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/people_detail.dart';

class GalleryState implements Cloneable<GalleryState> {
  ProfileImages images;
  GalleryState({this.images});

  @override
  GalleryState clone() {
    return GalleryState();
  }
}

GalleryState initState(Map<String, dynamic> args) {
  return GalleryState();
}
