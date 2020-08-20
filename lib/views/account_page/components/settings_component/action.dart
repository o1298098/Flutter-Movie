import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/item.dart';

enum SettingsAction {
  action,
  adultContentTapped,
  adultContentUpadte,
  notificationsTap,
  notificationsUpdate,
  checkUpdate,
  languageTap,
  setLanguage,
  darkModeTap,
  feedbackTap,
}

class SettingsActionCreator {
  static Action onAction() {
    return const Action(SettingsAction.action);
  }

  static Action notificationsTap() {
    return const Action(SettingsAction.notificationsTap);
  }

  static Action notificationsUpdate(bool enable) {
    return Action(SettingsAction.notificationsUpdate, payload: enable);
  }

  static Action adultContentTapped() {
    return Action(SettingsAction.adultContentTapped);
  }

  static Action adultContentUpadte(bool b) {
    return Action(SettingsAction.adultContentUpadte, payload: b);
  }

  static Action onCheckUpdate() {
    return const Action(SettingsAction.checkUpdate);
  }

  static Action darkModeTap() {
    return const Action(SettingsAction.darkModeTap);
  }

  static Action languageTap(Item language) {
    return Action(SettingsAction.languageTap, payload: language);
  }

  static Action setLanguage(Item language) {
    return Action(SettingsAction.setLanguage, payload: language);
  }

  static Action feedbackTap() {
    return const Action(SettingsAction.feedbackTap);
  }
}
