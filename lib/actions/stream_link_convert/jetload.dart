import 'dart:convert';

import 'package:dio/dio.dart';

class Jetload {
  static Future<String> getUrl(String link) async {
    String _link;
    String _replaceLink = link.replaceAll('/p/', '/e/');
    String v = '';
    String cb = '123456789';
    String siteKey = '6Lc90MkUAAAAAOrqIJqt4iXY_fkXb7j3zwgRGtUI';
    String co = 'aHR0cHM6Ly9qZXRsb2FkLm5ldDo0NDM.';
    String sa = 'secure_url';
    String _url =
        'https://www.google.com/recaptcha/api2/anchor?ar=1&k=$siteKey&co=$co&hl=ro&v=$v&size=invisible&cb=$cb';
    Map<String, String> _headers = {
      "Accept":
          "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
      "Accept-Language": "ro-RO,ro;q=0.8,en-US;q=0.6,en-GB;q=0.4,en;q=0.2",
      "referer": "https://jetload.net",
    };
    Response _response;
    try {
      _response = await Dio().get(_url, options: Options(headers: _headers));
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
          "Referer": _replaceLink
        };
        _response = await Dio().post('$_url2&$_post',
            options:
                Options(headers: _headers, responseType: ResponseType.plain));
        _regExp = new RegExp("\\/[p|e]\\/([a-zA-Z0-9_]+)", dotAll: true);
        _m = _regExp.firstMatch(_replaceLink);
        if (_m.groupCount > 0) {
          String streamid = _m.group(1);
          _regExp =
              new RegExp("rresp\\s*\"\\s*,\\s*\"\\s*(.*?)\"", dotAll: true);
          _m = _regExp.firstMatch(_response.data);
          if (_m.groupCount > 0) {
            _token = _m.group(1);
            _params = {"token": _token, "stream_code": streamid};
            String pars = "{\"token\":\"" +
                _token +
                "\",\"stream_code\":\"" +
                streamid +
                "\"}";
            _headers = {
              "Referer": _replaceLink,
              "Connection": "keep-alive",
              "Content-Length": pars.length.toString(),
              "Content-Type": "application/json;charset=UTF-8",
              "Accept-Encoding": "gzip, deflate, br",
              "Accept": "application/json, text/plain, */*",
              "Accept-Language":
                  "res-ES,es;q=0.9,en-US;q=0.8,en-GB;q=0.7,en;q=0.6,fr;q=0.5,id;q=0.4",
            };
            _response = await Dio(BaseOptions(headers: _headers))
                .post('https://jetload.net/jet_secure', data: pars);
            if (_response.data != null) if (_response.data["err"] == null) {
              final _srcData = _response.data["src"];
              _link = _srcData["src"];
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
