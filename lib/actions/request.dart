import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class Request {
  final String baseurl;
  Request(this.baseurl);
  Future<dynamic> request(String host,
      {String method = 'GET',
      dynamic data,
      bool cached = false,
      cacheDuration = const Duration(days: 1),
      maxStale = const Duration(days: 30)}) async {
    try {
      var dio = new Dio(BaseOptions(method: method, baseUrl: baseurl));
      if (cached)
        dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);
      var response = await dio.request(
        host,
        data: data,
        options: cached
            ? buildCacheOptions(
                cacheDuration,
                maxStale: maxStale,
              )
            : null,
      );
      return response.data;
    } on DioError catch (e) {
      return null;
    }
  }
}
