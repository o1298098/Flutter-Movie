import 'package:movie/models/enums/imagesize.dart';

class ImageUrl{
  static String getUrl(String param,ImageSize size)
  {
    String host='https://image.tmdb.org/t/p/';
    return host+size.toString().split('.').last+param;
  }
}