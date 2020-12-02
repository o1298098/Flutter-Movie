import 'dart:convert' show json;

import 'package:movie/models/base_api_model/stripe_address.dart';

class StripeCustomer {
  String id;
  String object;
  StripeAddress address;
  int balance;
  int created;
  String currency;
  String defaultSource;
  dynamic defaultSourceType;
  bool delinquent;
  String description;
  dynamic discount;
  String email;
  String invoicePrefix;
  InvoiceSettings invoiceSettings;
  bool livemode;
  String name;
  int nextInvoiceSequence;
  String phone;
  List<String> preferredLocales;
  Shipping shipping;
  dynamic sources;
  dynamic subscriptions;
  String taxExempt;
  dynamic taxIds;
  factory StripeCustomer(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new StripeCustomer.fromJson(json.decode(jsonStr))
          : new StripeCustomer.fromJson(jsonStr);
  StripeCustomer.fromParams(
      {this.id,
      this.object,
      this.address,
      this.balance,
      this.created,
      this.currency,
      this.defaultSource,
      this.defaultSourceType,
      this.delinquent,
      this.description,
      this.discount,
      this.email,
      this.invoicePrefix,
      this.invoiceSettings,
      this.livemode,
      this.name,
      this.nextInvoiceSequence,
      this.phone,
      this.preferredLocales,
      this.shipping,
      this.sources,
      this.subscriptions,
      this.taxExempt,
      this.taxIds});

  StripeCustomer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    address = json['address'] != null
        ? new StripeAddress.fromJson(json['address'])
        : null;
    balance = json['balance'];
    created = json['created'];
    currency = json['currency'];
    defaultSource = json['default_source'];
    defaultSourceType = json['default_source_type'];
    delinquent = json['delinquent'];
    description = json['description'];
    discount = json['discount'];
    email = json['email'];
    invoicePrefix = json['invoice_prefix'];
    invoiceSettings = json['invoice_settings'] != null
        ? new InvoiceSettings.fromJson(json['invoice_settings'])
        : null;
    livemode = json['livemode'];
    name = json['name'];
    nextInvoiceSequence = json['next_invoice_sequence'];
    phone = json['phone'];
    preferredLocales = json['preferred_locales'].cast<String>();
    shipping = json['shipping'] != null
        ? new Shipping.fromJson(json['shipping'])
        : null;
    sources = json['sources'];
    subscriptions = json['subscriptions'];
    taxExempt = json['tax_exempt'];
    taxIds = json['tax_ids'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['object'] = this.object;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['balance'] = this.balance;
    data['created'] = this.created;
    data['currency'] = this.currency;
    data['default_source'] = this.defaultSource;
    data['default_source_type'] = this.defaultSourceType;
    data['delinquent'] = this.delinquent;
    data['description'] = this.description;
    data['discount'] = this.discount;
    data['email'] = this.email;
    data['invoice_prefix'] = this.invoicePrefix;
    if (this.invoiceSettings != null) {
      data['invoice_settings'] = this.invoiceSettings.toJson();
    }
    data['livemode'] = this.livemode;
    data['name'] = this.name;
    data['next_invoice_sequence'] = this.nextInvoiceSequence;
    data['phone'] = this.phone;
    data['preferred_locales'] = this.preferredLocales;
    if (this.shipping != null) {
      data['shipping'] = this.shipping.toJson();
    }
    data['sources'] = this.sources;
    data['subscriptions'] = this.subscriptions;
    data['tax_exempt'] = this.taxExempt;
    data['tax_ids'] = this.taxIds;
    return data;
  }
}

class InvoiceSettings {
  Null customFields;
  Null defaultPaymentMethod;
  Null footer;

  InvoiceSettings({this.customFields, this.defaultPaymentMethod, this.footer});

  InvoiceSettings.fromJson(Map<String, dynamic> json) {
    customFields = json['custom_fields'];
    defaultPaymentMethod = json['default_payment_method'];
    footer = json['footer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['custom_fields'] = this.customFields;
    data['default_payment_method'] = this.defaultPaymentMethod;
    data['footer'] = this.footer;
    return data;
  }
}

class Shipping {
  StripeAddress address;
  dynamic carrier;
  String name;
  String phone;
  dynamic trackingNumber;

  Shipping(
      {this.address, this.carrier, this.name, this.phone, this.trackingNumber});

  Shipping.fromJson(Map<String, dynamic> json) {
    address = json['address'] != null
        ? new StripeAddress.fromJson(json['address'])
        : null;
    carrier = json['carrier'];
    name = json['name'];
    phone = json['phone'];
    trackingNumber = json['tracking_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['carrier'] = this.carrier;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['tracking_number'] = this.trackingNumber;
    return data;
  }
}
