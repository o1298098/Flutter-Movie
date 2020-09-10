import 'dart:convert' show json;

class PaymentClientToken {
  String token;
  int expiredTime;
  PaymentClientToken.fromParams({this.expiredTime, this.token});
  factory PaymentClientToken(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new PaymentClientToken.fromJson(json.decode(jsonStr))
          : new PaymentClientToken.fromJson(jsonStr);

  PaymentClientToken.fromJson(jsonRes) {
    token = jsonRes['token'];
    expiredTime = jsonRes['expiredTime'];
  }

  bool isExpired() {
    return DateTime.now().millisecondsSinceEpoch - expiredTime >= 86400000;
  }

  @override
  String toString() {
    return '{"token": "$token","expiredTime": $expiredTime}';
  }
}
