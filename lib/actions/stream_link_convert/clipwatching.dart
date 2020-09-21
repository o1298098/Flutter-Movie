import 'package:dio/dio.dart';
import 'package:movie/actions/api/urlresolver_api.dart';

class Clipwatching {
  static Future<String> getUrl(String link) async {
    String _link;
    try {
      final Response _response = await Dio().get(link);
      final _result = await UrlResolverApi.instance
          .getDirectUrl(_response.data, 'clipwatching', mode: 'local');
      if (_result.success) if (_result.result['status'] == 'ok')
        _link = _result.result['url'];
    } on DioError catch (_) {
      return null;
    }
    return _link;
  }
}
