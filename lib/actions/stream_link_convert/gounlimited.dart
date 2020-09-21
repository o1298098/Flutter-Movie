import 'package:dio/dio.dart';
import 'package:movie/actions/api/urlresolver_api.dart';

class Gounlimited {
  static Future<String> getUrl(String link) async {
    String _link;
    try {
      final Response _response = await Dio().get(link);
      final _result = await UrlResolverApi.instance
          .getDirectUrl(_response.data, 'gounlimited');
      if (_result.success) if (_result.result['status'] == 'ok') {
        final _data = _result.result['url'];
        _link = _data['src'];
      }
    } on DioError catch (_) {
      return null;
    }
    return _link;
  }
}
