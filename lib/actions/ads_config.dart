import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';

class AdsConfig {
  AdsConfig._();

  static final AdsConfig _instance = AdsConfig._();
  static AdsConfig get instance => _instance;

  final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    //testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>['movie', 'tv'],
    contentUrl: '',
    childDirected: true,
    nonPersonalizedAds: true,
  );

  final String unitId = Platform.isAndroid
      ? 'ca-app-pub-8117211796129035/4564399847'
      : 'ca-app-pub-8117211796129035/6998991498';
}
