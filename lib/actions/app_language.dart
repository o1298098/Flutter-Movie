import 'package:movie/models/item.dart';

import 'dart:ui' as ui;

import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage {
  AppLanguage._();
  static final AppLanguage instance = AppLanguage._();

  List<Item> get supportLanguages => [
        Item.fromParams(
            name: "System Default", value: ui.window.locale.languageCode),
        Item.fromParams(name: "Deutsch", value: 'de'),
        Item.fromParams(name: "English", value: 'en'),
        Item.fromParams(name: "Español", value: 'es'),
        Item.fromParams(name: "Français", value: 'fr'),
        Item.fromParams(name: "русский", value: 'ru'),
        Item.fromParams(name: "日本語", value: 'ja'),
        Item.fromParams(name: "简体中文", value: 'zh'),
        Item.fromParams(name: "繁體中文", value: 'zh-TW'),
      ];

  Future<Item> getApplanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _appLanguage = prefs.getString('appLanguage');
    if (_appLanguage != null) return Item(_appLanguage);
    return Item.fromParams(
        name: "System Default", value: ui.window.locale.languageCode);
  }
}
