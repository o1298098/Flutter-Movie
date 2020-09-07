import 'dart:convert';

import 'package:dio/dio.dart';

class Vidcloud {
  static Future<String> getUrl(String link) async {
    String _link;
    String v = 'JZfekeK8w6ZlhLfH_ZyseSLX';
    String cb = 'ilzxej5hmdxe';
    String siteKey = '6LdqXa0UAAAAABc77NIcku_LdXJio9kaJVpYkgQJ';
    String co = 'aHR0cHM6Ly92aWRjbG91ZC5ydTo0NDM.';
    String sa = 'get_playerr';
    String _url =
        'https://www.google.com/recaptcha/api2/anchor?ar=1&k=$siteKey&co=$co&hl=ro&v=$v&size=invisible&cb=$cb';
    Map<String, String> _headers = {
      "Accept":
          "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
      "Accept-Language": "ro-RO,ro;q=0.8,en-US;q=0.6,en-GB;q=0.4,en;q=0.2",
      "referer": "https://vidcloud.ru",
    };
    Response _response;
    try {
      _response = await Dio(BaseOptions(headers: _headers)).get(_url);
      RegExp _regExp = new RegExp(
          "recaptcha-token\"\\s*value\\s*=\\s*\"(.*?)\"",
          dotAll: true);
      RegExpMatch _m = _regExp.firstMatch(_response.data);
      if (_m.groupCount > 0) {
        String _token = _m.group(1);
        String _url2 =
            "https://www.google.com/recaptcha/api2/reload?k=" + siteKey;
        Map<String, String> _params = {
          'v': v,
          "reason": "q",
          "k": siteKey,
          "c": _token,
          "sa": sa,
          "co": co,
        };
        String _post = _params.keys
            .map((e) =>
                '${utf8.decode(e.codeUnits)}=${utf8.decode(_params[e].codeUnits)}')
            .join('&');
        _headers = {
          "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8",
          "Referer": link
        };
        _response = await Dio().post('$_url2&$_post',
            options:
                Options(headers: _headers, responseType: ResponseType.plain));
        _regExp = new RegExp("\\/[p|e]\\/([a-zA-Z0-9_]+)", dotAll: true);
        _m = _regExp.firstMatch(link);
        if (_m.groupCount > 0) {
          String streamid = _m.group(1);
          _regExp =
              new RegExp("rresp\\s*\"\\s*,\\s*\"\\s*(.*?)\"", dotAll: true);
          _m = _regExp.firstMatch(_response.data);
          if (_m.groupCount > 0) {
            _token = _m.group(1);
            String page = link.contains("/embed") ? "embed" : "video";

            _headers = {
              "Referer": link,
              "Connection": "keep-alive",
              "Accept-Encoding": "gzip, deflate, br",
              "Accept": "application/json, text/plain, */*",
              "Accept-Language":
                  "res-ES,es;q=0.9,en-US;q=0.8,en-GB;q=0.7,en;q=0.6,fr;q=0.5,id;q=0.4",
            };
            _response = await Dio(BaseOptions(headers: _headers))
                .get('https://vidcloud.ru/player', queryParameters: {
              'token': _token,
              'page': page,
              'fid': streamid,
            });
            if (_response.data != null) {
              String _jsonData = _response.data["html"];
              _regExp = new RegExp("sources\\s*=\\s*\\[(.*?)]");
              _m = _regExp.firstMatch(link);
              _jsonData = null;
              if (_m.groupCount > 0) _jsonData = _m.group(1);
              if (_jsonData != null) {
                final _arr = json.decode('[$_jsonData]');
                for (int i = 0; i < _arr.length(); i++) {
                  _link = _arr[i]['file'];
                  if (_link.contains(".mp4")) break;
                }

                if (_link != null) _link = _link.replaceAll("\\", "");
              }
            }
          }
        }
      }
    } on DioError catch (_) {
      print(_.toString());
      return null;
    } on Exception catch (_) {
      print(_.toString());
    }
    return _link;
  }
}
