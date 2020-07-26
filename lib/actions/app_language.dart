import 'package:movie/models/item.dart';

class AppLanguage {
  AppLanguage._();
  static final AppLanguage instance = AppLanguage._();

  List<Item> get supportLanguages => [
        Item.fromParams(name: "System Default"),
        Item.fromParams(name: "English", value: 'en'),
        Item.fromParams(name: "German", value: 'en'),
        Item.fromParams(name: "Japanese", value: 'ja'),
        Item.fromParams(name: "Chinese", value: 'zh'),
        Item.fromParams(name: "French", value: 'en'),
        Item.fromParams(name: "Spanish", value: 'en'),
      ];
}
