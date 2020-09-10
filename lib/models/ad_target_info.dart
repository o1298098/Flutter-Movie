import 'package:firebase_admob/firebase_admob.dart';

class AdTargetInfo {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    //testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>['movie', 'tv'],
    contentUrl: '',
    childDirected: true,
    nonPersonalizedAds: true,
  );
}
