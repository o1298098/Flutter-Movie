import 'package:dio/dio.dart';
import 'package:movie/actions/api/urlresolver_api.dart';

class Uptostream {
  static Future<String> getUrl(String link) async {
    String _link;
    String _replaceLink = link.replaceAll("uptobox.com", "uptostream.com");
    String _file = _replaceLink.split("/")[3];
    try {
      final Response _response = await Dio().get(
          'https://uptostream.com/api/streaming/source/get?token=null&file_code=$_file');
      final _result = await UrlResolverApi.instance
          .getDirectUrl(_response.data, 'uptostream');
      if (_result.success) if (_result.result['status'] == 'ok')
        _link = _result.result['url'];
    } on DioError catch (_) {
      return null;
    }
    return _link;
  }
}
