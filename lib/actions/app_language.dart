import 'package:movie/models/item.dart';

class AppLanguage {
  AppLanguage._();
  static final AppLanguage instance = AppLanguage._();

  List<Item> get supportLanguages => [
        Item.fromParams(name: "System Default"),
        Item.fromParams(name: "English", value: 'en'),
        Item.fromParams(name: "Deutsch", value: 'en'),
        Item.fromParams(name: "français", value: 'en'),
        Item.fromParams(name: "Español", value: 'en'),
        Item.fromParams(name: "日本語", value: 'ja'),
        Item.fromParams(name: "简体中文", value: 'zh'),
        Item.fromParams(name: "繁體中文", value: 'zh'),
      ];
}
