import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movie/actions/apihelper.dart';
import 'package:movie/actions/base_api.dart';
import 'package:movie/actions/github_api.dart';
import 'package:movie/actions/version_comparison.dart';
import 'package:movie/customwidgets/update_info_dialog.dart';
import 'package:movie/globalbasestate/action.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'action.dart';
import 'state.dart';

Effect<SettingPageState> buildEffect() {
  return combineEffects(<Object, Effect<SettingPageState>>{
    SettingPageAction.action: _onAction,
    SettingPageAction.adultCellTapped: _adultCellTapped,
    SettingPageAction.cleanCached: _cleanCached,
    SettingPageAction.profileEdit: _profileEdit,
    SettingPageAction.openPhotoPicker: _openPhotoPicker,
    SettingPageAction.checkUpdate: _checkUpdate,
    Lifecycle.initState: _onInit,
    Lifecycle.build: _onBuild,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<SettingPageState> ctx) {}

Future<void> _onInit(Action action, Context<SettingPageState> ctx) async {
  Object ticker = ctx.stfState;
  ctx.state.pageAnimation = AnimationController(
      vsync: ticker,
      duration: Duration(milliseconds: 800),
      reverseDuration: Duration(milliseconds: 300));
  ctx.state.userEditAnimation =
      AnimationController(vsync: ticker, duration: Duration(milliseconds: 300));
  _getCachedSize(ctx);
  ctx.state.userNameController =
      TextEditingController(text: ctx.state.userName ?? '')
        ..addListener(() {
          ctx.state.userName = ctx.state.userNameController.text;
        });
  ctx.state.phoneController = TextEditingController(text: ctx.state.phone ?? '')
    ..addListener(() {
      ctx.state.phone = ctx.state.phoneController.text;
    });
  ctx.state.photoController =
      TextEditingController(text: ctx.state.photoUrl ?? '')
        ..addListener(() {
          ctx.state.photoUrl = ctx.state.photoController.text;
        });

  final _packageInfo = await PackageInfo.fromPlatform();
  ctx.state.version = _packageInfo?.version ?? '-';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final _adultItem = prefs.getBool('adultItems');
  if (_adultItem != null) if (_adultItem != ctx.state.adultSwitchValue)
    ctx.dispatch(SettingPageActionCreator.adultValueUpadte(_adultItem));
}

void _cleanCached(Action action, Context<SettingPageState> ctx) async {
  await DefaultCacheManager().emptyCache();
  /*var appDir = (await getTemporaryDirectory()).path;
  new Directory(appDir).delete(recursive: true);*/
  _getCachedSize(ctx);
}

void _onDispose(Action action, Context<SettingPageState> ctx) {
  ctx.state.pageAnimation?.dispose();
  ctx.state.userEditAnimation?.dispose();
  ctx.state.userNameController.dispose();
  ctx.state.phoneController.dispose();
  ctx.state.photoController.dispose();
}

void _onBuild(Action action, Context<SettingPageState> ctx) {
  ctx.state.pageAnimation.forward();
}

void _adultCellTapped(Action action, Context<SettingPageState> ctx) async {
  final _b = ctx.state.adultSwitchValue ?? false;
  ctx.dispatch(SettingPageActionCreator.adultValueUpadte(!_b));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('adultItems', !_b);
  ApiHelper.includeAdult = !_b;
}

void _getCachedSize(Context<SettingPageState> ctx) async {
  final directory = Directory(await DefaultCacheManager().getFilePath());
  if (directory.existsSync()) {
    FileStat fileStat = directory.statSync();
    ctx.dispatch(
        SettingPageActionCreator.cacheSizeUpdate(fileStat.size / 1024.0));
  }
}

void _profileEdit(Action action, Context<SettingPageState> ctx) {
  if (ctx.state.user != null) {
    assert(ctx.state.userName != null && ctx.state.userName != '');
    assert(ctx.state.photoUrl != null && ctx.state.photoUrl != '');

    ctx.dispatch(SettingPageActionCreator.onUploading(true));
    final UserUpdateInfo _userInfo = UserUpdateInfo();
    _userInfo.displayName = ctx.state.userName;
    _userInfo.photoUrl = ctx.state.photoUrl;
    ctx.state.user.updateProfile(_userInfo)
      ..then((d) async {
        final _user = await FirebaseAuth.instance.currentUser();

        ctx.dispatch(SettingPageActionCreator.userUpadate(_user));

        GlobalStore.store.dispatch(GlobalActionCreator.setUser(_user));

        BaseApi.updateUser(_user.uid, _user.email, _user.photoUrl,
            _user.displayName, _user.phoneNumber);
        ctx.dispatch(SettingPageActionCreator.onUploading(false));
        ctx.state.userEditAnimation.reverse();
      });
  }
}

Future _openPhotoPicker(Action action, Context<SettingPageState> ctx) async {
  final _image = await ImagePicker.pickImage(
      source: ImageSource.gallery, maxHeight: 100, maxWidth: 100);
  if (_image != null) {
    ctx.dispatch(SettingPageActionCreator.onUploading(true));
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('avatar/${Path.basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      if (fileURL != null) {
        ctx.state.photoController.text = fileURL;
        ctx.dispatch(SettingPageActionCreator.userPanelPhotoUrlUpdate(fileURL));
      }
      ctx.dispatch(SettingPageActionCreator.onUploading(false));
    });
  }
}

Future _checkUpdate(Action action, Context<SettingPageState> ctx) async {
  if (!Platform.isAndroid) return;

  ctx.dispatch(SettingPageActionCreator.onLoading(true));
  final _github = GithubApi();
  final _result = await _github.checkUpdate();
  if (_result != null) {
    final _shouldUpdate =
        VersionComparison().compare(ctx.state.version, _result.tagName);
    final _apk = _result.assets.singleWhere(
        (e) => e.contentType == 'application/vnd.android.package-archive');

    if (_apk != null && _shouldUpdate) {
      await showDialog(
          context: ctx.context,
          child: UpdateInfoDialog(
            version: _result.tagName,
            describe: _result.body,
            packageSize: (_apk.size / 1048576),
            downloadUrl: _apk.browserDownloadUrl,
          ));
    }
    ctx.dispatch(SettingPageActionCreator.onLoading(false));
  }
}
