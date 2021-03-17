import 'dart:convert' show json;

import 'package:movie/models/base_api_model/stripe_address.dart';
import 'package:movie/models/base_api_model/stripe_creditcard.dart';

class StripeCharges {
  List<StripeCharge> list;

  StripeCharges.fromParams({this.list});

  factory StripeCharges(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new StripeCharges.fromJson(json.decode(jsonStr))
          : new StripeCharges.fromJson(jsonStr);

  StripeCharges.fromJson(jsonRes) {
    list = jsonRes == null ? null : [];

    for (var listItem in list == null ? [] : jsonRes) {
      list.add(listItem == null ? null : new StripeCharge.fromJson(listItem));
    }
  }

  @override
  String toString() {
    return '${list.toString()}';
  }
}

class StripeCharge {
  String id;
  String object;
  int amount;
  int amountCaptured;
  int amountRefunded;
  String application;
  String applicationFee;
  int applicationFeeAmount;
  String authorizationCode;
  String balanceTransaction;
  BillingDetails billingDetails;
  String calculatedStatementDescriptor;
  bool captured;
  int created;
  String currency;
  String customer;
  String description;
  String destination;
  dynamic dispute;
  bool disputed;
  String failureCode;
  String failureMessage;
  FraudDetails fraudDetails;
  String invoice;
  String level3;
  bool livemode;
  dynamic onBehalfOf;
  dynamic order;
  Outcome outcome;
  bool paid;
  String paymentIntent;
  String paymentMethod;
  PaymentMethodDetails paymentMethodDetails;
  String receiptEmail;
  String receiptNumber;
  String receiptUrl;
  bool refunded;
  Refunds refunds;
  dynamic review;
  dynamic shipping;
  dynamic source;
  dynamic sourceTransfer;
  dynamic statementDescriptor;
  dynamic statementDescriptorSuffix;
  String status;
  dynamic transfer;
  dynamic transferData;
  dynamic transferGroup;

  StripeCharge(
      {this.id,
      this.object,
      this.amount,
      this.amountCaptured,
      this.amountRefunded,
      this.application,
      this.applicationFee,
      this.applicationFeeAmount,
      this.authorizationCode,
      this.balanceTransaction,
      this.billingDetails,
      this.calculatedStatementDescriptor,
      this.captured,
      this.created,
      this.currency,
      this.customer,
      this.description,
      this.destination,
      this.dispute,
      this.disputed,
      this.failureCode,
      this.failureMessage,
      this.fraudDetails,
      this.invoice,
      this.level3,
      this.livemode,
      this.onBehalfOf,
      this.order,
      this.outcome,
      this.paid,
      this.paymentIntent,
      this.paymentMethod,
      this.paymentMethodDetails,
      this.receiptEmail,
      this.receiptNumber,
      this.receiptUrl,
      this.refunded,
      this.refunds,
      this.review,
      this.shipping,
      this.source,
      this.sourceTransfer,
      this.statementDescriptor,
      this.statementDescriptorSuffix,
      this.status,
      this.transfer,
      this.transferData,
      this.transferGroup});

  StripeCharge.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    amount = json['amount'];
    amountCaptured = json['amount_captured'];
    amountRefunded = json['amount_refunded'];
    application = json['application'];
    applicationFee = json['application_fee'];
    applicationFeeAmount = json['application_fee_amount'];
    authorizationCode = json['authorization_code'];
    balanceTransaction = json['balance_transaction'];
    billingDetails = json['billing_details'] != null
        ? new BillingDetails.fromJson(json['billing_details'])
        : null;
    calculatedStatementDescriptor = json['calculated_statement_descriptor'];
    captured = json['captured'];
    created = json['created'];
    currency = json['currency'];
    customer = json['customer'];
    description = json['description'];
    destination = json['destination'];
    dispute = json['dispute'];
    disputed = json['disputed'];
    failureCode = json['failure_code'];
    failureMessage = json['failure_message'];
    fraudDetails = json['fraud_details'] != null
        ? new FraudDetails.fromJson(json['fraud_details'])
        : null;
    invoice = json['invoice'];
    level3 = json['level3'];
    livemode = json['livemode'];
    onBehalfOf = json['on_behalf_of'];
    order = json['order'];
    outcome =
        json['outcome'] != null ? new Outcome.fromJson(json['outcome']) : null;
    paid = json['paid'];
    paymentIntent = json['payment_intent'];
    paymentMethod = json['payment_method'];
    paymentMethodDetails = json['payment_method_details'] != null
        ? new PaymentMethodDetails.fromJson(json['payment_method_details'])
        : null;
    receiptEmail = json['receipt_email'];
    receiptNumber = json['receipt_number'];
    receiptUrl = json['receipt_url'];
    refunded = json['refunded'];
    refunds =
        json['refunds'] != null ? new Refunds.fromJson(json['refunds']) : null;
    review = json['review'];
    shipping = json['shipping'];
    source = json['source'];
    sourceTransfer = json['source_transfer'];
    statementDescriptor = json['statement_descriptor'];
    statementDescriptorSuffix = json['statement_descriptor_suffix'];
    status = json['status'];
    transfer = json['transfer'];
    transferData = json['transfer_data'];
    transferGroup = json['transfer_group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['object'] = this.object;
    data['amount'] = this.amount;
    data['amount_captured'] = this.amountCaptured;
    data['amount_refunded'] = this.amountRefunded;
    data['application'] = this.application;
    data['application_fee'] = this.applicationFee;
    data['application_fee_amount'] = this.applicationFeeAmount;
    data['authorization_code'] = this.authorizationCode;
    data['balance_transaction'] = this.balanceTransaction;
    if (this.billingDetails != null) {
      data['billing_details'] = this.billingDetails.toJson();
    }
    data['calculated_statement_descriptor'] =
        this.calculatedStatementDescriptor;
    data['captured'] = this.captured;
    data['created'] = this.created;
    data['currency'] = this.currency;
    data['customer'] = this.customer;
    data['description'] = this.description;
    data['destination'] = this.destination;
    data['dispute'] = this.dispute;
    data['disputed'] = this.disputed;
    data['failure_code'] = this.failureCode;
    data['failure_message'] = this.failureMessage;
    if (this.fraudDetails != null) {
      data['fraud_details'] = this.fraudDetails.toJson();
    }
    data['invoice'] = this.invoice;
    data['level3'] = this.level3;
    data['livemode'] = this.livemode;
    data['on_behalf_of'] = this.onBehalfOf;
    data['order'] = this.order;
    if (this.outcome != null) {
      data['outcome'] = this.outcome.toJson();
    }
    data['paid'] = this.paid;
    data['payment_intent'] = this.paymentIntent;
    data['payment_method'] = this.paymentMethod;
    if (this.paymentMethodDetails != null) {
      data['payment_method_details'] = this.paymentMethodDetails.toJson();
    }
    data['receipt_email'] = this.receiptEmail;
    data['receipt_number'] = this.receiptNumber;
    data['receipt_url'] = this.receiptUrl;
    data['refunded'] = this.refunded;
    if (this.refunds != null) {
      data['refunds'] = this.refunds.toJson();
    }
    data['review'] = this.review;
    data['shipping'] = this.shipping;
    data['source'] = this.source;
    data['source_transfer'] = this.sourceTransfer;
    data['statement_descriptor'] = this.statementDescriptor;
    data['statement_descriptor_suffix'] = this.statementDescriptorSuffix;
    data['status'] = this.status;
    data['transfer'] = this.transfer;
    data['transfer_data'] = this.transferData;
    data['transfer_group'] = this.transferGroup;
    return data;
  }
}

class BillingDetails {
  StripeAddress address;
  String email;
  String name;
  String phone;

  BillingDetails({this.address, this.email, this.name, this.phone});

  BillingDetails.fromJson(Map<String, dynamic> json) {
    address = json['address'] != null
        ? new StripeAddress.fromJson(json['address'])
        : null;
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}

class FraudDetails {
  dynamic stripeReport;
  dynamic userReport;

  FraudDetails({this.stripeReport, this.userReport});

  FraudDetails.fromJson(Map<String, dynamic> json) {
    stripeReport = json['stripe_report'];
    userReport = json['user_report'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stripe_report'] = this.stripeReport;
    data['user_report'] = this.userReport;
    return data;
  }
}

class Outcome {
  String networkStatus;
  String reason;
  String riskLevel;
  int riskScore;
  dynamic rule;
  String sellerMessage;
  String type;

  Outcome(
      {this.networkStatus,
      this.reason,
      this.riskLevel,
      this.riskScore,
      this.rule,
      this.sellerMessage,
      this.type});

  Outcome.fromJson(Map<String, dynamic> json) {
    networkStatus = json['network_status'];
    reason = json['reason'];
    riskLevel = json['risk_level'];
    riskScore = json['risk_score'];
    rule = json['rule'];
    sellerMessage = json['seller_message'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['network_status'] = this.networkStatus;
    data['reason'] = this.reason;
    data['risk_level'] = this.riskLevel;
    data['risk_score'] = this.riskScore;
    data['rule'] = this.rule;
    data['seller_message'] = this.sellerMessage;
    data['type'] = this.type;
    return data;
  }
}

class PaymentMethodDetails {
  dynamic achCreditTransfer;
  dynamic achDebit;
  dynamic acssDebit;
  dynamic alipay;
  dynamic auBecsDebit;
  dynamic bacsDebit;
  dynamic bancontact;
  StripeCreditCard card;
  dynamic cardPresent;
  dynamic eps;
  dynamic fpx;
  dynamic giropay;
  dynamic grabpay;
  dynamic ideal;
  dynamic interacPresent;
  dynamic klarna;
  dynamic multibanco;
  dynamic oxxo;
  dynamic p24;
  dynamic sepaDebit;
  dynamic stripeAccount;
  String type;
  dynamic wechat;

  PaymentMethodDetails(
      {this.achCreditTransfer,
      this.achDebit,
      this.acssDebit,
      this.alipay,
      this.auBecsDebit,
      this.bacsDebit,
      this.bancontact,
      this.card,
      this.cardPresent,
      this.eps,
      this.fpx,
      this.giropay,
      this.grabpay,
      this.ideal,
      this.interacPresent,
      this.klarna,
      this.multibanco,
      this.oxxo,
      this.p24,
      this.sepaDebit,
      this.stripeAccount,
      this.type,
      this.wechat});

  PaymentMethodDetails.fromJson(Map<String, dynamic> json) {
    achCreditTransfer = json['ach_credit_transfer'];
    achDebit = json['ach_debit'];
    acssDebit = json['acss_debit'];
    alipay = json['alipay'];
    auBecsDebit = json['au_becs_debit'];
    bacsDebit = json['bacs_debit'];
    bancontact = json['bancontact'];
    card = json['card'] != null
        ? new StripeCreditCard.fromJson(json['card'])
        : null;
    cardPresent = json['card_present'];
    eps = json['eps'];
    fpx = json['fpx'];
    giropay = json['giropay'];
    grabpay = json['grabpay'];
    ideal = json['ideal'];
    interacPresent = json['interac_present'];
    klarna = json['klarna'];
    multibanco = json['multibanco'];
    oxxo = json['oxxo'];
    p24 = json['p24'];
    sepaDebit = json['sepa_debit'];
    stripeAccount = json['stripe_account'];
    type = json['type'];
    wechat = json['wechat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ach_credit_transfer'] = this.achCreditTransfer;
    data['ach_debit'] = this.achDebit;
    data['acss_debit'] = this.acssDebit;
    data['alipay'] = this.alipay;
    data['au_becs_debit'] = this.auBecsDebit;
    data['bacs_debit'] = this.bacsDebit;
    data['bancontact'] = this.bancontact;
    if (this.card != null) {
      data['card'] = this.card.toJson();
    }
    data['card_present'] = this.cardPresent;
    data['eps'] = this.eps;
    data['fpx'] = this.fpx;
    data['giropay'] = this.giropay;
    data['grabpay'] = this.grabpay;
    data['ideal'] = this.ideal;
    data['interac_present'] = this.interacPresent;
    data['klarna'] = this.klarna;
    data['multibanco'] = this.multibanco;
    data['oxxo'] = this.oxxo;
    data['p24'] = this.p24;
    data['sepa_debit'] = this.sepaDebit;
    data['stripe_account'] = this.stripeAccount;
    data['type'] = this.type;
    data['wechat'] = this.wechat;
    return data;
  }
}

class Checks {
  Null addressLine1Check;
  Null addressPostalCodeCheck;
  Null cvcCheck;

  Checks({this.addressLine1Check, this.addressPostalCodeCheck, this.cvcCheck});

  Checks.fromJson(Map<String, dynamic> json) {
    addressLine1Check = json['address_line1_check'];
    addressPostalCodeCheck = json['address_postal_code_check'];
    cvcCheck = json['cvc_check'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_line1_check'] = this.addressLine1Check;
    data['address_postal_code_check'] = this.addressPostalCodeCheck;
    data['cvc_check'] = this.cvcCheck;
    return data;
  }
}

class Refunds {
  String object;
  List<dynamic> data;
  bool hasMore;
  String url;

  Refunds({this.object, this.data, this.hasMore, this.url});

  Refunds.fromJson(Map<String, dynamic> json) {
    object = json['object'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(v);
      });
    }
    hasMore = json['has_more'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['object'] = this.object;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['has_more'] = this.hasMore;
    data['url'] = this.url;
    return data;
  }
}
