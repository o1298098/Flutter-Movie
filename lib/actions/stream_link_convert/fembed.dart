import 'package:dio/dio.dart';

class Fembed {
  static Future<String> getUrl(String link) async {
    String _link;
    String _file = link.split('/')[4];
    try {
      final Response _response = await Dio().post(
        'https://feurl.com/api/source/$_file',
        data: {
          'r': '',
          'd': 'feurl.com',
        },
      );

      if (_response.data != null) if (_response.data['success']) {
        final _data = _response.data['data'];
        _link = _data[0]['file'];
      }
    } on DioError catch (_) {
      return null;
    }
    return _link;
  }
}
