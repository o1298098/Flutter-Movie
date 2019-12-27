import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class Request {
  final String baseurl;
  Request(this.baseurl);
  Future<dynamic> request(String host,
      {String method = 'GET',
      dynamic data,
      dynamic queryParameters,
      bool cached = false,
      Map<String, Object> headers,
      cacheDuration = const Duration(days: 1),
      maxStale = const Duration(days: 30)}) async {
    try {
      var dio = new Dio(BaseOptions(method: method, baseUrl: baseurl));
      if (cached)
        dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);
      if (headers != null) dio..options.headers = headers;
      var response = await dio.request(
        host,
        data: data,
        queryParameters: queryParameters,
        options: cached
            ? buildCacheOptions(
                cacheDuration,
                maxStale: maxStale,
              )
            : null,
      );
      return response.data;
    } on DioError catch (_) {
      return null;
    }
  }
}
