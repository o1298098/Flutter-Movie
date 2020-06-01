import 'package:common_utils/common_utils.dart';

class TimelineInfoEN implements TimelineInfo {
  String suffixAgo() => ' ago';
  String suffixAfter() => ' after';
  String lessThanTenSecond() => 'just now';
  String customYesterday() => 'Yesterday';
  bool keepOneDay() => false;
  bool keepTwoDays() => true;
  String oneMinute(int minutes) => 'a minute';
  String minutes(int minutes) => '$minutes minutes';
  String anHour(int hours) => 'an hour';
  String hours(int hours) => '$hours hours';
  String oneDay(int days) => 'a day';
  String days(int days) => '$days days';
  DayFormat dayFormat() => DayFormat.Common;

  @override
  String lessThanOneMinute() {
    return 'one minute ago';
  }

  @override
  int maxJustNowSecond() {
    return 10;
  }

  @override
  String weeks(int week) {
    throw '$week weeks ago';
  }
}

class TimelineInfoCN implements TimelineInfo {
  String suffixAgo() => '前';
  String suffixAfter() => '后';
  String lessThanTenSecond() => '刚刚';
  String customYesterday() => '昨天';
  bool keepOneDay() => false;
  bool keepTwoDays() => true;
  String oneMinute(int minutes) => '$minutes分钟';
  String minutes(int minutes) => '$minutes分钟';
  String anHour(int hours) => '$hours小时';
  String hours(int hours) => '$hours小时';
  String oneDay(int days) => '$days天';
  String days(int days) => '$days天';
  DayFormat dayFormat() => DayFormat.Common;

  @override
  String lessThanOneMinute() {
    return '1 分钟前';
  }

  @override
  int maxJustNowSecond() {
    return 10;
  }

  @override
  String weeks(int week) {
    return '$week 星期前';
  }
}

class TimelineInfoJA implements TimelineInfo {
  String suffixAgo() => ' ago';
  String suffixAfter() => ' after';
  String lessThanTenSecond() => 'just now';
  String customYesterday() => 'Yesterday';
  bool keepOneDay() => false;
  bool keepTwoDays() => true;
  String oneMinute(int minutes) => 'a minute';
  String minutes(int minutes) => '$minutes minutes';
  String anHour(int hours) => 'an hour';
  String hours(int hours) => '$hours hours';
  String oneDay(int days) => 'a day';
  String days(int days) => '$days days';
  DayFormat dayFormat() => DayFormat.Common;

  @override
  String lessThanOneMinute() {
    return 'one minute ago';
  }

  @override
  int maxJustNowSecond() {
    return 10;
  }

  @override
  String weeks(int week) {
    throw '$week weeks ago';
  }
}
