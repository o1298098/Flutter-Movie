import 'package:dio/dio.dart';
import 'package:movie/actions/api/urlresolver_api.dart';

class Waaw {
  static Future<String> getUrl(String link) async {
    String _link;
    try {
      final Response _response = await Dio().get(link,
          options: Options(headers: {
            "accept": "*/*",
          }));
      final _result =
          await UrlResolverApi.instance.getDirectUrl(_response.data, 'waaw');
      if (_result.success) if (_result.result['status'] == 'ok')
        _link = _result.result['url'];
    } on DioError catch (_) {
      return null;
    }
    return _link;
  }
}
