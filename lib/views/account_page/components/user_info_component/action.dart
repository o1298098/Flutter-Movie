import 'package:fish_redux/fish_redux.dart';

enum UserInfoAction {
  action,
  openMenu,
  signIn,
  signOut,
  openNotifications,
  paymentTap
}

class UserInfoActionCreator {
  static Action onAction() {
    return const Action(UserInfoAction.action);
  }

  static Action openMenu() {
    return const Action(UserInfoAction.openMenu);
  }

  static Action signOut() {
    return const Action(UserInfoAction.signOut);
  }

  static Action signIn() {
    return const Action(UserInfoAction.signIn);
  }

  static Action openNotifications() {
    return const Action(UserInfoAction.openNotifications);
  }

  static Action paymentTap() {
    return const Action(UserInfoAction.paymentTap);
  }
}
