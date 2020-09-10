import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/notification_model.dart';

import 'action.dart';
import 'state.dart';

Reducer<NotificationState> buildReducer() {
  return asReducer(
    <Object, Reducer<NotificationState>>{
      NotificationAction.action: _onAction,
      NotificationAction.setNotifications: _setNotifications,
    },
  );
}

NotificationState _onAction(NotificationState state, Action action) {
  final NotificationState newState = state.clone();
  return newState;
}

NotificationState _setNotifications(NotificationState state, Action action) {
  final NotificationList _list = action.payload;
  final NotificationState newState = state.clone();
  newState.notificationList = _list;
  return newState;
}
