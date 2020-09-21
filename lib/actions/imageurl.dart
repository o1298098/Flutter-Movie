import 'package:movie/models/enums/imagesize.dart';

class ImageUrl {
  static String emptyimage = 'https://www.color-hex.com/palettes/7707.png';
  static String getUrl(String param, ImageSize size) {
    String host = 'https://image.tmdb.org/t/p/';
    return param == null
        ? emptyimage
        : host + size.toString().split('.').last + param;
  }

  static String getGravatarUrl(String hash, int size) {
    return hash == null
        ? 'https://www.gravatar.com/avatar'
        : 'https://www.gravatar.com/avatar/$hash?size=$size';
  }
}
