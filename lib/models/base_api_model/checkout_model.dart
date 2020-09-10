import 'package:flutter/material.dart';
import 'package:movie/models/enums/premium_type.dart';

class CheckOutModel {
  String name;
  double amount;
  String url;
  bool isPremium;
  PremiumType premiumType;
  CheckOutModel({
    @required this.name,
    @required this.amount,
    this.isPremium = false,
    this.url,
    this.premiumType = PremiumType.oneMonth,
  });
}
