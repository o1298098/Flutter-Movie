import 'package:movie/actions/api/urlresolver_api.dart';

class Vidia {
  static Future<String> getUrl(String link) async {
    String _link;

    final _result = await UrlResolverApi.instance.getDirectUrl(link, 'vidia');
    if (_result.success) if (_result.result['status'] == 'ok')
      _link = _result.result['url'];

    return _link;
  }
}
