import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/item.dart';

enum SettingPageAction {
  action,
  adultCellTapped,
  adultValueUpadte,
  languageTap,
  setLanguage,
  cleanCached,
  cachedSizeUpdate,
  profileEdit,
  userUpdate,
  openPhotoPicker,
  userPanelPhotoUrlUpdate,
  uploading,
  loading,
  checkUpdate,
}

class SettingPageActionCreator {
  static Action onAction() {
    return const Action(SettingPageAction.action);
  }

  static Action adultCellTapped() {
    return Action(SettingPageAction.adultCellTapped);
  }

  static Action adultValueUpadte(bool b) {
    return Action(SettingPageAction.adultValueUpadte, payload: b);
  }

  static Action cleanCached() {
    return Action(SettingPageAction.cleanCached);
  }

  static Action cacheSizeUpdate(double d) {
    return Action(SettingPageAction.cachedSizeUpdate, payload: d);
  }

  static Action profileEdit() {
    return Action(SettingPageAction.profileEdit);
  }

  static Action userUpadate(FirebaseUser user) {
    return Action(SettingPageAction.userUpdate, payload: user);
  }

  static Action openPhotoPicker() {
    return const Action(SettingPageAction.openPhotoPicker);
  }

  static Action userPanelPhotoUrlUpdate(String url) {
    return Action(SettingPageAction.userPanelPhotoUrlUpdate, payload: url);
  }

  static Action onUploading(bool isUploading) {
    return Action(SettingPageAction.uploading, payload: isUploading);
  }

  static Action onLoading(bool isLoading) {
    return Action(SettingPageAction.loading, payload: isLoading);
  }

  static Action onCheckUpdate() {
    return const Action(SettingPageAction.checkUpdate);
  }

  static Action languageTap(Item language) {
    return Action(SettingPageAction.languageTap, payload: language);
  }

  static Action setLanguage(Item language) {
    return Action(SettingPageAction.setLanguage, payload: language);
  }
}
