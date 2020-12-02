import 'dart:convert' show json;

class StripeCreditCards {
  List<StripeCreditCard> list;

  StripeCreditCards.fromParams({this.list});

  factory StripeCreditCards(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new StripeCreditCards.fromJson(json.decode(jsonStr))
          : new StripeCreditCards.fromJson(jsonStr);

  StripeCreditCards.fromJson(jsonRes) {
    list = jsonRes == null ? null : [];

    for (var listItem in list == null ? [] : jsonRes) {
      list.add(
          listItem == null ? null : new StripeCreditCard.fromJson(listItem));
    }
  }

  @override
  String toString() {
    return '${list.toString()}';
  }
}

class StripeCreditCard {
  StripeCreditCard(
      {this.id,
      this.object,
      this.account,
      this.addressCity,
      this.addressCountry,
      this.addressLine1,
      this.addressLine1Check,
      this.addressLine2,
      this.addressState,
      this.addressZip,
      this.addressZipCheck,
      this.availablePayoutMethods,
      this.brand,
      this.country,
      this.currency,
      this.customer,
      this.cvcCheck,
      this.defaultForCurrency,
      this.description,
      this.dynamicLast4,
      this.expMonth,
      this.expYear,
      this.fingerprint,
      this.funding,
      this.iin,
      this.issuer,
      this.last4,
      this.metadata,
      this.name,
      this.tokenizationMethod,
      this.wallet});

  String id;
  String object;
  dynamic account;
  dynamic addressCity;
  dynamic addressCountry;
  dynamic addressLine1;
  dynamic addressLine1Check;
  dynamic addressLine2;
  dynamic addressState;
  dynamic addressZip;
  dynamic addressZipCheck;
  dynamic availablePayoutMethods;
  String brand;
  String country;
  dynamic currency;
  String customer;
  dynamic cvcCheck;
  dynamic defaultForCurrency;
  dynamic description;
  String dynamicLast4;
  int expMonth;
  int expYear;
  String fingerprint;
  String funding;
  dynamic iin;
  dynamic issuer;
  String last4;
  Metadata metadata;
  dynamic name;
  String tokenizationMethod;
  Wallet wallet;

  factory StripeCreditCard.fromJson(Map<String, dynamic> json) =>
      StripeCreditCard(
          id: json["id"],
          object: json["object"],
          account: json["account"],
          addressCity: json["address_city"],
          addressCountry: json["address_country"],
          addressLine1: json["address_line1"],
          addressLine1Check: json["address_line1_check"],
          addressLine2: json["address_line2"],
          addressState: json["address_state"],
          addressZip: json["address_zip"],
          addressZipCheck: json["address_zip_check"],
          availablePayoutMethods: json["available_payout_methods"],
          brand: json["brand"],
          country: json["country"],
          currency: json["currency"],
          customer: json["customer"],
          cvcCheck: json["cvc_check"],
          defaultForCurrency: json["default_for_currency"],
          description: json["description"],
          dynamicLast4: json["dynamic_last4"],
          expMonth: json["exp_month"],
          expYear: json["exp_year"],
          fingerprint: json["fingerprint"],
          funding: json["funding"],
          iin: json["iin"],
          issuer: json["issuer"],
          last4: json["last4"],
          metadata: Metadata.fromJson(json["metadata"]),
          name: json["name"],
          tokenizationMethod: json["tokenization_method"],
          wallet: json['wallet'] != null
              ? new Wallet.fromJson(json['wallet'])
              : null);

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "account": account,
        "address_city": addressCity,
        "address_country": addressCountry,
        "address_line1": addressLine1,
        "address_line1_check": addressLine1Check,
        "address_line2": addressLine2,
        "address_state": addressState,
        "address_zip": addressZip,
        "address_zip_check": addressZipCheck,
        "available_payout_methods": availablePayoutMethods,
        "brand": brand,
        "country": country,
        "currency": currency,
        "customer": customer,
        "cvc_check": cvcCheck,
        "default_for_currency": defaultForCurrency,
        "description": description,
        "dynamic_last4": dynamicLast4,
        "exp_month": expMonth,
        "exp_year": expYear,
        "fingerprint": fingerprint,
        "funding": funding,
        "iin": iin,
        "issuer": issuer,
        "last4": last4,
        "metadata": metadata.toJson(),
        "name": name,
        "tokenization_method": tokenizationMethod,
      };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toJson() => {};
}

class Wallet {
  dynamic amexExpressCheckout;
  dynamic applePay;
  String dynamicLast4;
  dynamic googlePay;
  dynamic masterpass;
  dynamic samsungPay;
  String type;
  dynamic visaCheckout;

  Wallet(
      {this.amexExpressCheckout,
      this.applePay,
      this.dynamicLast4,
      this.googlePay,
      this.masterpass,
      this.samsungPay,
      this.type,
      this.visaCheckout});

  Wallet.fromJson(Map<String, dynamic> json) {
    amexExpressCheckout = json['amex_express_checkout'];
    applePay = json['apple_pay'];
    dynamicLast4 = json['dynamic_last4'];
    googlePay = json['google_pay'];
    masterpass = json['masterpass'];
    samsungPay = json['samsung_pay'];
    type = json['type'];
    visaCheckout = json['visa_checkout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amex_express_checkout'] = this.amexExpressCheckout;
    if (this.applePay != null) {
      data['apple_pay'] = this.applePay.toJson();
    }
    data['dynamic_last4'] = this.dynamicLast4;
    data['google_pay'] = this.googlePay;
    data['masterpass'] = this.masterpass;
    data['samsung_pay'] = this.samsungPay;
    data['type'] = this.type;
    data['visa_checkout'] = this.visaCheckout;
    return data;
  }
}
