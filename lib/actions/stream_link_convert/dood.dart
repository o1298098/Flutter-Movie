import 'package:dio/dio.dart';
import 'package:movie/actions/api/urlresolver_api.dart';

class Dood {
  static Future<String> getUrl(String link) async {
    String _link;
    Response _response;
    String _replaceLink = link.replaceAll("/e/", "/d/");
    String _embedRegex = "\\/pass_md5\\/(.*?)[\'|\"]";
    String _downloadRegex = "\\/download\\/(.*?)[\'|\"]";
    try {
      _response = await Dio().get(_replaceLink,
          options: Options(headers: {'referrer': _replaceLink}));
      RegExp _regExp = new RegExp(_downloadRegex, dotAll: true);
      RegExpMatch _m = _regExp.firstMatch(_response.data);
      if (_m.groupCount > 0) {
        String _downloadLink = "https://dood.watch/download/" + _m.group(1);
        _response = await Dio().get(_downloadLink,
            options: Options(headers: {'referrer': _replaceLink}));
        final _result = await UrlResolverApi.instance
            .getDirectUrl(_response.data, 'dood', mode: 'direct');
        if (_result.success) if (_result.result['status'] == 'ok')
          _link = _result.result['url'];
      }
      if (_link == null || _link?.isEmpty == true) {
        _replaceLink =
            _replaceLink.replaceAll("/d/", "/e/").replaceAll("/h/", "/e/");

        _response = await Dio().get(_replaceLink);
        RegExp _regExp2 = new RegExp(_embedRegex, dotAll: true);
        RegExpMatch _m2 = _regExp2.firstMatch(_response.data);
        if (_m2.groupCount > 0) {
          String _pasrs = _m2.group(1);
          String _embedLink = "https://dood.watch/pass_md5/" + _pasrs;
          _response = await Dio().get(_embedLink);
          final _result2 = await UrlResolverApi.instance.getDirectUrl(
              _response.data, 'dood',
              mode: 'embed', token: _pasrs);
          if (_result2.success) if (_result2.result['status'] == 'ok')
            _link = _result2.result['url'];
        }
      }
    } on DioError catch (_) {
      return null;
    }
    return _link;
  }
}
