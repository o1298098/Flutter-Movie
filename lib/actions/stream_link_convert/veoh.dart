import 'package:dio/dio.dart';
import 'package:movie/actions/api/urlresolver_api.dart';

class Veoh {
  static Future<String> getUrl(String link) async {
    String _link;
    String _replaceLink = link.contains("/getVideo/")
        ? link
        : "https://www.veoh.com/watch/getVideo/" + link.split("/")[4];
    try {
      final Response _response =
          await Dio(BaseOptions(headers: {'User-Agent': 'Mozilla'}))
              .get(_replaceLink);
      final _result = await UrlResolverApi.instance
          .getDirectUrl(_response.data, 'veoh', mode: 'local');
      if (_result.success) if (_result.result['status'] == 'ok')
        _link = _result.result['url'];
    } on DioError catch (_) {
      return null;
    }
    return _link;
  }
}
