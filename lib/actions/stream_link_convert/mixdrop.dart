import 'package:dio/dio.dart';
import 'package:movie/actions/api/urlresolver_api.dart';

class Mixdrop {
  static Future<String> getUrl(String link) async {
    String _link;
    String _replaceLink = link.replaceAll("/f/", "/e/");
    Response _response;
    Map<String, String> mapHeaders = {'Referer': _replaceLink};
    try {
      _response = await Dio(BaseOptions(headers: mapHeaders)).get(_replaceLink);
      if (_response.data == null ||
          !_response.data.toString().contains('eval(')) {
        if (_response.data != null) {
          RegExp _regExp =
              new RegExp("window.location\\s*=\\s*\"(.*?)\"", dotAll: true);
          RegExpMatch _m = _regExp.firstMatch(_response.data.toString());
          if (_m.groupCount > 0) {
            String token = _m.group(1);
            if (token != null && token?.isEmpty == false) {
              _replaceLink = _replaceLink.split("/e/")[0] + token;
              _response =
                  await Dio(BaseOptions(headers: mapHeaders)).get(_replaceLink);
            }
          }
        }
      }
      final _result = await UrlResolverApi.instance
          .getDirectUrl(_response.data.toString(), 'mixdrop');
      if (_result.success) if (_result.result['status'] == 'ok')
        _link = _result.result['url'];
    } on DioError catch (_) {
      return null;
    }
    return _link;
  }
}
