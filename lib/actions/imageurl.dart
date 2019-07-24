import 'package:flutter/cupertino.dart';
import 'package:movie/models/enums/imagesize.dart';

class ImageUrl{

  static String emptyimage='http://www.shonephotography.com/wp-content/themes/trend/assets/img/empty/424x500.png';
  static String getUrl(String param,ImageSize size)
  {
    String host='https://image.tmdb.org/t/p/';
    return param==null?emptyimage: host+size.toString().split('.').last+param;
  }

  static String getGravatarUrl(String hash,int size){
    return hash==null?'https://www.gravatar.com/avatar':'https://www.gravatar.com/avatar/$hash?size=$size';
  }
}