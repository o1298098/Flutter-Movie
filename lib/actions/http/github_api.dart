import 'package:movie/models/models.dart';

import 'request.dart';

class GithubApi {
  GithubApi._();
  static final GithubApi instance = GithubApi._();
  final Request _http = Request('https://api.github.com');

  Future<ResponseModel<GithubReleaseModel>> checkUpdate() async {
    final String _parma = '/repos/o1298098/flutter-movie/releases/latest';
    final _result = await _http.request<GithubReleaseModel>(_parma);
    return _result;
  }
}
