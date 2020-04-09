import 'package:flutter/material.dart';

class CountryPhoneCode {
  String name, code, dialCode, flag;

  CountryPhoneCode({this.name, this.code, this.dialCode, this.flag});

  factory CountryPhoneCode.fromJson(Map<String, dynamic> json) =>
      CountryPhoneCode(
          name: json["name"],
          code: json["code"],
          dialCode: json["dial_code"],
          flag: json["flag"]);

  @override
  String toString() {
    return '{name: $name, code: $code, dialCode: $dialCode}';
  }

  static Future<String> getCountryJson(BuildContext context) async {
    final _jsonStr = await DefaultAssetBundle.of(context)
        .loadString("lib/models/country_phone_codes.json");
    return _jsonStr;
  }
}
