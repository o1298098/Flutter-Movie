import 'package:dio/dio.dart';
import 'package:movie/actions/api/urlresolver_api.dart';

class Videobin {
  static Future<String> getUrl(String link) async {
    String _link;
    String _replaceLink = link.contains("/embed-")
        ? link
        : "https://videobin.co/embed-" + link.split("/")[3];
    try {
      final Response _response = await Dio().get(_replaceLink);
      final _result = await UrlResolverApi.instance
          .getDirectUrl(_response.data, 'videobin');
      if (_result.success) if (_result.result['status'] == 'ok')
        _link = _result.result['url'];
    } on DioError catch (_) {
      return null;
    }
    return _link;
  }
}
