import 'dart:convert' show json;

import 'braintree_item_type.dart';
import 'braintree_transaction.dart';

class BraintreeSubscription {
  Object daysPastDue;
  Object description;
  Object numberOfBillingCycles;
  Object trialDuration;
  Object trialDurationUnit;
  int billingDayOfMonth;
  int currentBillingCycle;
  int failureCount;
  double balance;
  double nextBillAmount;
  double nextBillingPeriodAmount;
  double price;
  bool hasTrialPeriod;
  bool neverExpires;
  String billingPeriodEndDate;
  String billingPeriodStartDate;
  String createdAt;
  String firstBillingDate;
  String id;
  String merchantAccountId;
  String nextBillingDate;
  String paidThroughDate;
  String paymentMethodToken;
  String planId;
  String updatedAt;
  List<dynamic> addOns;
  List<dynamic> discounts;
  List<StatusHistory> statusHistory;
  List<Transaction> transactions;
  Descriptor descriptor;
  ItemType status;

  BraintreeSubscription.fromParams(
      {this.daysPastDue,
      this.description,
      this.numberOfBillingCycles,
      this.trialDuration,
      this.trialDurationUnit,
      this.billingDayOfMonth,
      this.currentBillingCycle,
      this.failureCount,
      this.balance,
      this.nextBillAmount,
      this.nextBillingPeriodAmount,
      this.price,
      this.hasTrialPeriod,
      this.neverExpires,
      this.billingPeriodEndDate,
      this.billingPeriodStartDate,
      this.createdAt,
      this.firstBillingDate,
      this.id,
      this.merchantAccountId,
      this.nextBillingDate,
      this.paidThroughDate,
      this.paymentMethodToken,
      this.planId,
      this.updatedAt,
      this.addOns,
      this.discounts,
      this.statusHistory,
      this.transactions,
      this.descriptor,
      this.status});

  factory BraintreeSubscription(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new BraintreeSubscription.fromJson(json.decode(jsonStr))
          : new BraintreeSubscription.fromJson(jsonStr);

  BraintreeSubscription.fromJson(jsonRes) {
    daysPastDue = jsonRes['DaysPastDue'];
    description = jsonRes['Description'];
    numberOfBillingCycles = jsonRes['NumberOfBillingCycles'];
    trialDuration = jsonRes['TrialDuration'];
    trialDurationUnit = jsonRes['TrialDurationUnit'];
    billingDayOfMonth = jsonRes['BillingDayOfMonth'];
    currentBillingCycle = jsonRes['CurrentBillingCycle'];
    failureCount = jsonRes['FailureCount'];
    balance = jsonRes['Balance'];
    nextBillAmount = jsonRes['NextBillAmount'];
    nextBillingPeriodAmount = jsonRes['NextBillingPeriodAmount'];
    price = jsonRes['Price'];
    hasTrialPeriod = jsonRes['HasTrialPeriod'];
    neverExpires = jsonRes['NeverExpires'];
    billingPeriodEndDate = jsonRes['BillingPeriodEndDate'];
    billingPeriodStartDate = jsonRes['BillingPeriodStartDate'];
    createdAt = jsonRes['CreatedAt'];
    firstBillingDate = jsonRes['FirstBillingDate'];
    id = jsonRes['Id'];
    merchantAccountId = jsonRes['MerchantAccountId'];
    nextBillingDate = jsonRes['NextBillingDate'];
    paidThroughDate = jsonRes['PaidThroughDate'];
    paymentMethodToken = jsonRes['PaymentMethodToken'];
    planId = jsonRes['PlanId'];
    updatedAt = jsonRes['UpdatedAt'];
    addOns = jsonRes['AddOns'] == null ? null : [];

    for (var addOnsItem in addOns == null ? [] : jsonRes['AddOns']) {
      addOns.add(addOnsItem);
    }

    discounts = jsonRes['Discounts'] == null ? null : [];

    for (var discountsItem in discounts == null ? [] : jsonRes['Discounts']) {
      discounts.add(discountsItem);
    }

    statusHistory = jsonRes['StatusHistory'] == null ? null : [];

    for (var statusHistoryItem
        in statusHistory == null ? [] : jsonRes['StatusHistory']) {
      statusHistory.add(statusHistoryItem == null
          ? null
          : new StatusHistory.fromJson(statusHistoryItem));
    }

    transactions = jsonRes['Transactions'] == null ? null : [];

    for (var transactionsItem
        in transactions == null ? [] : jsonRes['Transactions']) {
      transactions.add(transactionsItem == null
          ? null
          : new Transaction.fromJson(transactionsItem));
    }

    descriptor = jsonRes['Descriptor'] == null
        ? null
        : new Descriptor.fromJson(jsonRes['Descriptor']);
    status = jsonRes['Status'] == null
        ? null
        : new ItemType.fromJson(jsonRes['Status']);
  }

  @override
  String toString() {
    return '{"DaysPastDue": $daysPastDue,"Description": $description,"NumberOfBillingCycles": $numberOfBillingCycles,"TrialDuration": $trialDuration,"TrialDurationUnit": $trialDurationUnit,"BillingDayOfMonth": $billingDayOfMonth,"CurrentBillingCycle": $currentBillingCycle,"FailureCount": $failureCount,"Balance": $balance,"NextBillAmount": $nextBillAmount,"NextBillingPeriodAmount": $nextBillingPeriodAmount,"Price": $price,"HasTrialPeriod": $hasTrialPeriod,"NeverExpires": $neverExpires,"BillingPeriodEndDate": ${billingPeriodEndDate != null ? '${json.encode(billingPeriodEndDate)}' : 'null'},"BillingPeriodStartDate": ${billingPeriodStartDate != null ? '${json.encode(billingPeriodStartDate)}' : 'null'},"CreatedAt": ${createdAt != null ? '${json.encode(createdAt)}' : 'null'},"FirstBillingDate": ${firstBillingDate != null ? '${json.encode(firstBillingDate)}' : 'null'},"Id": ${id != null ? '${json.encode(id)}' : 'null'},"MerchantAccountId": ${merchantAccountId != null ? '${json.encode(merchantAccountId)}' : 'null'},"NextBillingDate": ${nextBillingDate != null ? '${json.encode(nextBillingDate)}' : 'null'},"PaidThroughDate": ${paidThroughDate != null ? '${json.encode(paidThroughDate)}' : 'null'},"PaymentMethodToken": ${paymentMethodToken != null ? '${json.encode(paymentMethodToken)}' : 'null'},"PlanId": ${planId != null ? '${json.encode(planId)}' : 'null'},"UpdatedAt": ${updatedAt != null ? '${json.encode(updatedAt)}' : 'null'},"AddOns": $addOns,"Discounts": $discounts,"StatusHistory": $statusHistory,"Transactions": $transactions,"Descriptor": $descriptor,"Status": $status}';
  }
}

class Descriptor {
  Object name;
  Object phone;
  Object url;

  Descriptor.fromParams({this.name, this.phone, this.url});

  Descriptor.fromJson(jsonRes) {
    name = jsonRes['Name'];
    phone = jsonRes['Phone'];
    url = jsonRes['Url'];
  }

  @override
  String toString() {
    return '{"Name": $name,"Phone": $phone,"Url": $url}';
  }
}

class SubscriptionDetails {
  String billingPeriodEndDate;
  String billingPeriodStartDate;

  SubscriptionDetails.fromParams(
      {this.billingPeriodEndDate, this.billingPeriodStartDate});

  SubscriptionDetails.fromJson(jsonRes) {
    billingPeriodEndDate = jsonRes['BillingPeriodEndDate'];
    billingPeriodStartDate = jsonRes['BillingPeriodStartDate'];
  }

  @override
  String toString() {
    return '{"BillingPeriodEndDate": ${billingPeriodEndDate != null ? '${json.encode(billingPeriodEndDate)}' : 'null'},"BillingPeriodStartDate": ${billingPeriodStartDate != null ? '${json.encode(billingPeriodStartDate)}' : 'null'}}';
  }
}

class DisbursementDetails {
  Object disbursementDate;
  Object fundsHeld;
  Object settlementAmount;
  Object settlementCurrencyExchangeRate;
  Object settlementCurrencyIsoCode;
  Object success;

  DisbursementDetails.fromParams(
      {this.disbursementDate,
      this.fundsHeld,
      this.settlementAmount,
      this.settlementCurrencyExchangeRate,
      this.settlementCurrencyIsoCode,
      this.success});

  DisbursementDetails.fromJson(jsonRes) {
    disbursementDate = jsonRes['DisbursementDate'];
    fundsHeld = jsonRes['FundsHeld'];
    settlementAmount = jsonRes['SettlementAmount'];
    settlementCurrencyExchangeRate = jsonRes['SettlementCurrencyExchangeRate'];
    settlementCurrencyIsoCode = jsonRes['SettlementCurrencyIsoCode'];
    success = jsonRes['Success'];
  }

  @override
  String toString() {
    return '{"DisbursementDate": $disbursementDate,"FundsHeld": $fundsHeld,"SettlementAmount": $settlementAmount,"SettlementCurrencyExchangeRate": $settlementCurrencyExchangeRate,"SettlementCurrencyIsoCode": $settlementCurrencyIsoCode,"Success": $success}';
  }
}

class CustomerDetails {
  Object company;
  Object email;
  Object fax;
  Object firstName;
  Object lastName;
  Object phone;
  Object website;
  String id;

  CustomerDetails.fromParams(
      {this.company,
      this.email,
      this.fax,
      this.firstName,
      this.lastName,
      this.phone,
      this.website,
      this.id});

  CustomerDetails.fromJson(jsonRes) {
    company = jsonRes['Company'];
    email = jsonRes['Email'];
    fax = jsonRes['Fax'];
    firstName = jsonRes['FirstName'];
    lastName = jsonRes['LastName'];
    phone = jsonRes['Phone'];
    website = jsonRes['Website'];
    id = jsonRes['Id'];
  }

  @override
  String toString() {
    return '{"Company": $company,"Email": $email,"Fax": $fax,"FirstName": $firstName,"LastName": $lastName,"Phone": $phone,"Website": $website,"Id": ${id != null ? '${json.encode(id)}' : 'null'}}';
  }
}

class StatusHistory {
  double amount;
  String timestamp;
  String user;
  ItemType source;
  ItemType status;

  StatusHistory.fromParams(
      {this.amount, this.timestamp, this.user, this.source, this.status});

  StatusHistory.fromJson(jsonRes) {
    amount = jsonRes['Amount'];
    timestamp = jsonRes['Timestamp'];
    user = jsonRes['User'];
    source = jsonRes['Source'] == null
        ? null
        : new ItemType.fromJson(jsonRes['Source']);
    status = jsonRes['Status'] == null
        ? null
        : new ItemType.fromJson(jsonRes['Status']);
  }

  @override
  String toString() {
    return '{"Amount": $amount,"Timestamp": ${timestamp != null ? '${json.encode(timestamp)}' : 'null'},"User": ${user != null ? '${json.encode(user)}' : 'null'},"Source": $source,"Status": $status}';
  }
}
