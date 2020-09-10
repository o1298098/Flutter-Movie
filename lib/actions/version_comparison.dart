import 'dart:math' as math;

class VersionComparison {
  bool compare(String now, String release) {
    final List<String> _v1 = now.replaceAll("v", "").split('.');
    final List<String> _v2 = release.replaceAll("v", "").split('.');
    final _v1Lenght = _v1.length;
    final _v2Lenght = _v2.length;
    final _maxLenght = math.max(_v1Lenght, _v2Lenght);
    final int _l = (_v1Lenght - _v2Lenght).abs();

    if (_v1Lenght == 0 && _v2Lenght == 0)
      return false;
    else if (_v1Lenght == 0)
      return true;
    else if (_v2Lenght == 0) return false;

    if (_v1Lenght < _v2Lenght)
      for (int i = 0; i < _l; i++) _v1.add('0');
    else if (_v1Lenght > _v2Lenght) for (int i = 0; i < _l; i++) _v2.add('0');

    for (int i = 0; i < _maxLenght; i++) {
      int _r = _compareNum(int.parse(_v1[i]), int.parse(_v2[i]));
      if (_r == 0)
        continue;
      else {
        if (_r == -1)
          return true;
        else
          return false;
      }
    }
    return false;
  }

  int _compareNum(int n1, int n2) {
    if (n1 > n2) {
      return 1;
    } else if (n1 < n2) {
      return -1;
    } else {
      return 0;
    }
  }
}
