import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  FirebaseUser firebaseUser;
  DateTime premiumExpireDate;
  bool get isPremium => premiumExpireDate == null
      ? false
      : premiumExpireDate.compareTo(DateTime.now()) > 0;
  AppUser({this.firebaseUser, this.premiumExpireDate});
}
