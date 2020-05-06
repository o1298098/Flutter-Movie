import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie/globalbasestate/action.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_api.dart';

class UserInfoOperate {
  static bool isPremium = false;
  static String premiumExpireDate;

  static Future whenLogin(FirebaseUser user, String nickName) async {
    GlobalStore.store.dispatch(GlobalActionCreator.setUser(user));
    BaseApi.updateUser(
        user.uid, user.email, user.photoUrl, nickName, user.phoneNumber);
    final _r = await BaseApi.getUserPremium(user.uid);
    if (_r != null) {
      if (_r.status) {
        if (_r.data == null) return;
        if (_r.data.expireDate == null) return;
        await setPremium(_r.data.expireDate);
      }
    }
    print(_r);
  }

  static Future<bool> whenLogout() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser currentUser = await _auth.currentUser();
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    if (currentUser != null) {
      try {
        _auth.signOut();
        _preferences.remove('PaymentToken');
        _preferences.remove('premiumExpireDate');
        premiumExpireDate = null;
        checkPremium();
        GlobalStore.store.dispatch(GlobalActionCreator.setUser(null));
      } on Exception catch (_) {
        return false;
      }
      return true;
    }
    return false;
  }

  static Future whenAppStart() async {
    var _user = await FirebaseAuth.instance.currentUser();
    if (_user != null) {
      GlobalStore.store.dispatch(GlobalActionCreator.setUser(_user));
      SharedPreferences _preferences = await SharedPreferences.getInstance();
      String _date = _preferences.getString('premiumExpireDate');
      if (_date == null) return;
      premiumExpireDate = _date;
      checkPremium();
    }
  }

  static Future setPremium(String date) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString('premiumExpireDate', date);
    premiumExpireDate = date;
    checkPremium();
  }

  static bool checkPremium() {
    isPremium = premiumExpireDate == null
        ? false
        : DateTime.parse(premiumExpireDate).compareTo(DateTime.now()) > 0;
    return isPremium;
  }
}
