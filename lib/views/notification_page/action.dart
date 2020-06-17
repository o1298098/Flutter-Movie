import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/notification_model.dart';

enum NotificationAction { action, setNotifications, cellTapped }

class NotificationActionCreator {
  static Action onAction() {
    return const Action(NotificationAction.action);
  }

  static Action setNotifications(NotificationList list) {
    return Action(NotificationAction.setNotifications, payload: list);
  }

  static Action cellTapped(NotificationModel data) {
    return Action(NotificationAction.cellTapped, payload: data);
  }
}
