import 'package:dio/dio.dart';
import 'package:movie/actions/api/urlresolver_api.dart';

class Videomega {
  static Future<String> getUrl(String link) async {
    String _link;
    String _replaceLink = link.contains("/e/")
        ? link
        : "https://www.videomega.co/e/" + link.split("/")[3];
    try {
      final Response _response = await Dio().get(_replaceLink);
      final _result = await UrlResolverApi.instance
          .getDirectUrl(_response.data, 'videomega');
      if (_result.success) if (_result.result['status'] == 'ok')
        _link = _result.result['url'];
    } on DioError catch (_) {
      return null;
    }
    return _link;
  }
}
