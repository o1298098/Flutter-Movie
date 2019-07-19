import 'package:movie/models/enums/imagesize.dart';

class ImageUrl{
  static String getUrl(String param,ImageSize size)
  {
    String host='https://image.tmdb.org/t/p/';
    return param==null?emptyimage: host+size.toString().split('.').last+param;
  }
  static String emptyimage='http://www.shonephotography.com/wp-content/themes/trend/assets/img/empty/424x500.png';
}