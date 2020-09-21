import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:movie/models/model_factory.dart';
import 'package:movie/models/response_model.dart';

class Request {
  final String baseurl;
  Dio _dio;
  Request(this.baseurl) {
    _dio = new Dio(BaseOptions(baseUrl: baseurl));
  }

  Future<ResponseModel<T>> request<T>(String host,
      {String method = 'GET',
      dynamic data,
      dynamic queryParameters,
      bool cached = false,
      Map<String, Object> headers,
      Duration cacheDuration = const Duration(days: 1),
      Duration maxStale = const Duration(days: 30)}) async {
    try {
      if (cached)
        _dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);
      if (headers != null) _dio.options.headers = headers;
      _dio.options.method = method;
      final response = await _dio.request(
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
      return ResponseModel<T>(
          statusCode: response.statusCode,
          message: response.statusMessage,
          result: ModelFactory.generate(response.data));
    } on DioError catch (_) {
      return ResponseModel(
          statusCode: _.response?.statusCode ?? _.type.index,
          message: _.message);
    }
  }
}
