import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/globalbasestate/store.dart';

class SettingPageState implements Cloneable<SettingPageState> {
  AnimationController pageAnimation;
  AnimationController userEditAnimation;
  FirebaseUser user;
  String userName;
  String photoUrl;
  String phone;
  TextEditingController userNameController;
  TextEditingController photoController;
  TextEditingController phoneController;
  bool adultSwitchValue;
  bool isEditProfile;
  double cachedSize;
  @override
  SettingPageState clone() {
    return SettingPageState()
      ..pageAnimation = pageAnimation
      ..userEditAnimation = userEditAnimation
      ..adultSwitchValue = adultSwitchValue
      ..isEditProfile = isEditProfile
      ..cachedSize = cachedSize
      ..user = user
      ..userName = userName
      ..phone = phone
      ..photoUrl = photoUrl
      ..userNameController = userNameController
      ..phoneController = phoneController
      ..photoController = photoController;
  }
}

SettingPageState initState(Map<String, dynamic> args) {
  SettingPageState state = SettingPageState();
  final user = GlobalStore.store.getState().user;
  if (user != null) {
    state.user = user;
    state.userName = user.displayName;
    state.phone = user.phoneNumber;
    state.photoUrl = user.photoUrl;
  }
  state.adultSwitchValue = false;
  state.isEditProfile = false;
  state.cachedSize = 0;
  return state;
}
