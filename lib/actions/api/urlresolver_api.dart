import 'package:movie/actions/app_config.dart';
import 'package:movie/actions/api/request.dart';
import 'package:movie/models/models.dart';
import 'dart:convert';

class UrlResolverApi {
  UrlResolverApi._();
  static final UrlResolverApi _instance = UrlResolverApi._();
  static UrlResolverApi get instance => _instance;
  final Request _http = Request(AppConfig.instance.urlresolverApiHost);
  final String _apiKey = AppConfig.instance.urlresolverApiKey;

  Future<ResponseModel<dynamic>> getDirectUrl(String link, String domain,
      {String mode, String token}) async {
    final String _url = '/$domain';
    final String _auth = '{"auth":"","skk":"$_apiKey"}';
    final _data = {
      'source': base64.encode(utf8.encode(link)),
      'auth': base64.encode(utf8.encode(_auth)),
    };
    if (mode != null) _data['mode'] = '$mode';
    if (token != null) _data['token'] = token;
    return await _http.request(_url, method: 'POST', data: _data);
  }
}
