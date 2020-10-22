import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie/globalbasestate/action.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/models/base_api_model/user_premium_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/base_api.dart';

class UserInfoOperate {
  static bool isPremium = false;
  static String premiumExpireDate;

  static Future whenLogin(FirebaseUser user, String nickName) async {
    final _baseApi = BaseApi.instance;
    _baseApi.updateUser(
        user.uid, user.email, user.photoUrl, nickName, user.phoneNumber);

    GlobalStore.store.dispatch(GlobalActionCreator.setUser(
        AppUser(firebaseUser: user, premium: null)));
    final _r = await _baseApi.getUserPremium(user.uid);
    if (_r.success) {
      if (_r.result.status) {
        if (_r.result.data != null) await setPremium(_r.result.data);
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
        _preferences.remove('premiumData');
        premiumExpireDate = null;
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
      SharedPreferences _preferences = await SharedPreferences.getInstance();
      UserPremiumData _premiumData;
      String _data = _preferences.getString('premiumData');
      if (_data != null) _premiumData = UserPremiumData(_data);
      GlobalStore.store.dispatch(GlobalActionCreator.setUser(
          AppUser(firebaseUser: _user, premium: _premiumData)));
    } else
      GlobalStore.store.dispatch(GlobalActionCreator.setUser(AppUser()));
  }

  static Future setPremium(UserPremiumData userPremiumData) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString('premiumData', userPremiumData.toString());
    GlobalStore.store
        .dispatch(GlobalActionCreator.setUserPremium(userPremiumData));
  }

  static bool checkPremium() {
    isPremium = premiumExpireDate == null
        ? false
        : DateTime.parse(premiumExpireDate).compareTo(DateTime.now()) > 0;
    return isPremium;
  }
}
