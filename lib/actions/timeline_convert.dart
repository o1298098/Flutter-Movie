import 'package:common_utils/common_utils.dart';
import 'dart:ui' as ui;

class TimeLineConvert {
  TimeLineConvert._();
  static final TimeLineConvert instance = TimeLineConvert._();
  String getTimeLine(String date) {
    var _date = DateTime.parse(date ?? '1970-07-10');
    final String _timeline = TimelineUtil.format(
      _date.millisecondsSinceEpoch,
      locTimeMs: DateTime.now().millisecondsSinceEpoch,
      locale: ui.window.locale.languageCode,
    );
    return _timeline;
  }
}
