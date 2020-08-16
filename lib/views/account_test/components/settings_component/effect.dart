import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/http/github_api.dart';
import 'package:movie/actions/http/tmdb_api.dart';
import 'package:movie/actions/version_comparison.dart';
import 'package:movie/globalbasestate/action.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/models/item.dart';
import 'package:movie/views/account_test/action.dart';
import 'package:movie/widgets/update_info_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'action.dart';
import 'state.dart';

Effect<SettingsState> buildEffect() {
  return combineEffects(<Object, Effect<SettingsState>>{
    SettingsAction.action: _onAction,
    SettingsAction.adultContentTapped: _adultContentTapped,
    SettingsAction.languageTap: _languageTap,
    SettingsAction.checkUpdate: _checkUpdate,
    SettingsAction.darkModeTap: _darkModeTap,
    SettingsAction.feedbackTap: _feedbackTap,
    SettingsAction.notificationsTap: _notificationsTap,
  });
}

void _onAction(Action action, Context<SettingsState> ctx) {}

void _adultContentTapped(Action action, Context<SettingsState> ctx) async {
  final _b = !(ctx.state.adultContent ?? false);
  ctx.dispatch(SettingsActionCreator.adultContentUpadte(_b));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('adultItems', _b);
  TMDBApi.instance.setAdultValue(_b);
}

Future _checkUpdate(Action action, Context<SettingsState> ctx) async {
  if (!Platform.isAndroid) return;

  //ctx.dispatch(SettingPageActionCreator.onLoading(true));
  final _github = GithubApi.instance;
  final _result = await _github.checkUpdate();
  if (_result.success) {
    final _shouldUpdate =
        VersionComparison().compare(ctx.state.version, _result.result.tagName);
    final _apk = _result.result.assets.singleWhere(
        (e) => e.contentType == 'application/vnd.android.package-archive');

    if (_apk != null && _shouldUpdate) {
      await showDialog(
        context: ctx.context,
        child: UpdateInfoDialog(
          version: _result.result.tagName,
          describe: _result.result.body,
          packageSize: (_apk.size / 1048576),
          downloadUrl: _apk.browserDownloadUrl,
        ),
      );
    } else
      Toast.show('Already up to date', ctx.context);
  } else
    Toast.show(_result.message, ctx.context);
  //ctx.dispatch(SettingPageActionCreator.onLoading(false));
}

void _languageTap(Action action, Context<SettingsState> ctx) async {
  final Item _language = action.payload;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (_language.name == 'System Default')
    prefs.remove('appLanguage');
  else
    prefs.setString('appLanguage', _language.toString());
  ctx.dispatch(SettingsActionCreator.setLanguage(_language));
  GlobalStore.store.dispatch(GlobalActionCreator.changeLocale(
      _language.value == null ? null : Locale(_language.value)));
  TMDBApi.instance.setLanguage(_language.value);
  //ctx.dispatch(AccountActionCreator.showTip('need to reopen app'));
}

void _darkModeTap(Action action, Context<SettingsState> ctx) {
  ctx.dispatch(AccountActionCreator.showTip('Unavailable at this moment'));
}

void _notificationsTap(Action action, Context<SettingsState> ctx) async {
  ctx.dispatch(AccountActionCreator.showTip('Unavailable at this moment'));
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String _movieTypeUsbcirbed = _prefs.getString('movieTypeSubscribed');
  print(_movieTypeUsbcirbed);
  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
}

void _feedbackTap(Action action, Context<SettingsState> ctx) {
  ctx.dispatch(
      AccountActionCreator.showTip('Feedback unavailable at this moment'));
}
