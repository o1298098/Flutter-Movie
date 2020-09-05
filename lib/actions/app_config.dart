import 'package:flutter/material.dart';
import 'dart:convert' show json;

class AppConfig {
  AppConfig._();

  static final AppConfig instance = AppConfig._();

  dynamic _config;

  String get theMovieDBHostV3 => _config['theMovieDBHostV3'];

  String get theMovieDBHostV4 => _config['theMovieDBHostV4'];

  String get theMovieDBApiKeyV3 => _config['theMovieDBApiKeyV3'];

  String get theMovieDBApiKeyV4 => _config['theMovieDBApiKeyV4'];

  String get baseApiHost => _config['baseApiHost'];

  String get graphQLHttpLink => _config['graphQLHttpLink'];

  String get graphQlWebSocketLink => _config['graphQlWebSocketLink'];

  String get urlresolverApiHost => _config['urlresolverApiHost'];

  String get urlresolverApiKey => _config['urlresolverApiKey'];

  Future init(BuildContext context) async {
    final _jsonStr = await _getConfigJson(context);
    if (_jsonStr == null) {
      print('can not find config file');
      return;
    }
    _config = json.decode(_jsonStr);
  }

  Future<String> _getConfigJson(BuildContext context) async {
    try {
      final _jsonStr =
          await DefaultAssetBundle.of(context).loadString("appconfig.json");
      return _jsonStr;
    } on Exception catch (_) {
      return null;
    }
  }
}
