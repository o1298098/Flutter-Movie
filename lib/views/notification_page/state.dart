import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/notification_model.dart';

class NotificationState implements Cloneable<NotificationState> {
  NotificationList notificationList;
  @override
  NotificationState clone() {
    return NotificationState()..notificationList = notificationList;
  }
}

NotificationState initState(Map<String, dynamic> args) {
  return NotificationState();
}
