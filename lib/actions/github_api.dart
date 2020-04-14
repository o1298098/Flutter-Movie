import 'package:movie/actions/request.dart';
import 'package:movie/models/github_release.dart';

class GithubApi {
  Request _http = Request('https://api.github.com');

  Future<GithubReleaseModel> checkUpdate() async {
    GithubReleaseModel _model;
    String _parma = '/repos/o1298098/flutter-movie/releases/latest';
    final _result = await _http.request(_parma);
    if (_result != null) _model = GithubReleaseModel(_result);
    return _model;
  }
}
