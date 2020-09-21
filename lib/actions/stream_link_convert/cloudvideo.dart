import 'package:dio/dio.dart';
import 'package:movie/actions/api/urlresolver_api.dart';

class CloudVideo {
  static Future<String> getUrl(String link) async {
    String _link = link.contains("/embed-")
        ? link
        : "https://cloudvideo.tv/embed-" +
            link.replaceAll(".html", "").split("/")[3] +
            ".html";
    try {
      final Response _response = await Dio().get(_link);
      final _result = await UrlResolverApi.instance
          .getDirectUrl(_response.data, 'cloudvideo', mode: 'local');
      if (_result.success) if (_result.result['status'] == 'ok')
        _link = _result.result['url'];
    } on DioError catch (_) {
      return null;
    }
    return _link;
  }
}
