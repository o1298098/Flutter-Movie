import 'braintree_billing_address.dart';
import 'braintree_item_type.dart';
import 'braintree_subscription.dart';
import 'dart:convert' show json;

class CreditCard {
  Object accountType;
  String cardholderName;
  Object createdAt;
  String customerId;
  String imageUrl;
  bool isDefault;
  bool isExpired;
  Object isVenmoSdk;
  Object updatedAt;
  Object verification;
  String bin;
  String countryOfIssuance;
  String expirationDate;
  String expirationMonth;
  String expirationYear;
  String issuingBank;
  String lastFour;
  String maskedNumber;
  String productId;
  String token;
  String uniqueNumberIdentifier;
  List<BraintreeSubscription> subscriptions;
  BillingAddress billingAddress;
  ItemType cardType;
  ItemType commercial;
  ItemType customerLocation;
  ItemType debit;
  ItemType durbinRegulated;
  ItemType healthcare;
  ItemType payroll;
  ItemType prepaid;
  factory CreditCard(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new CreditCard.fromJson(json.decode(jsonStr))
          : new CreditCard.fromJson(jsonStr);
  CreditCard.fromParams(
      {this.accountType,
      this.cardholderName,
      this.createdAt,
      this.customerId,
      this.imageUrl,
      this.isDefault,
      this.isExpired,
      this.isVenmoSdk,
      this.updatedAt,
      this.verification,
      this.bin,
      this.countryOfIssuance,
      this.expirationDate,
      this.expirationMonth,
      this.expirationYear,
      this.issuingBank,
      this.lastFour,
      this.maskedNumber,
      this.productId,
      this.token,
      this.uniqueNumberIdentifier,
      this.subscriptions,
      this.billingAddress,
      this.cardType,
      this.commercial,
      this.customerLocation,
      this.debit,
      this.durbinRegulated,
      this.healthcare,
      this.payroll,
      this.prepaid});

  CreditCard.fromJson(jsonRes) {
    accountType = jsonRes['AccountType'];
    cardholderName = jsonRes['CardholderName'];
    createdAt = jsonRes['CreatedAt'];
    customerId = jsonRes['CustomerId'];
    imageUrl = jsonRes['ImageUrl'];
    isDefault = jsonRes['IsDefault'];
    isExpired = jsonRes['IsExpired'];
    isVenmoSdk = jsonRes['IsVenmoSdk'];
    updatedAt = jsonRes['UpdatedAt'];
    verification = jsonRes['Verification'];
    bin = jsonRes['Bin'];
    countryOfIssuance = jsonRes['CountryOfIssuance'];
    expirationDate = jsonRes['ExpirationDate'];
    expirationMonth = jsonRes['ExpirationMonth'];
    expirationYear = jsonRes['ExpirationYear'];
    issuingBank = jsonRes['IssuingBank'];
    lastFour = jsonRes['LastFour'];
    maskedNumber = jsonRes['MaskedNumber'];
    productId = jsonRes['ProductId'];
    token = jsonRes['Token'];
    uniqueNumberIdentifier = jsonRes['UniqueNumberIdentifier'];
    subscriptions = jsonRes['Subscriptions'] == null ? null : [];

    for (var subscriptionsItem
        in subscriptions == null ? [] : jsonRes['Subscriptions']) {
      subscriptions.add(BraintreeSubscription(subscriptionsItem));
    }

    billingAddress = jsonRes['BillingAddress'] == null
        ? null
        : new BillingAddress.fromJson(jsonRes['BillingAddress']);
    cardType = jsonRes['CardType'] == null
        ? null
        : new ItemType.fromJson(jsonRes['CardType']);
    commercial = jsonRes['Commercial'] == null
        ? null
        : new ItemType.fromJson(jsonRes['Commercial']);
    customerLocation = jsonRes['CustomerLocation'] == null
        ? null
        : new ItemType.fromJson(jsonRes['CustomerLocation']);
    debit = jsonRes['Debit'] == null
        ? null
        : new ItemType.fromJson(jsonRes['Debit']);
    durbinRegulated = jsonRes['DurbinRegulated'] == null
        ? null
        : new ItemType.fromJson(jsonRes['DurbinRegulated']);
    healthcare = jsonRes['Healthcare'] == null
        ? null
        : new ItemType.fromJson(jsonRes['Healthcare']);
    payroll = jsonRes['Payroll'] == null
        ? null
        : new ItemType.fromJson(jsonRes['Payroll']);
    prepaid = jsonRes['Prepaid'] == null
        ? null
        : new ItemType.fromJson(jsonRes['Prepaid']);
  }

  @override
  String toString() {
    return '{"AccountType": $accountType,"CardholderName": $cardholderName,"CreatedAt": $createdAt,"CustomerId": $customerId,"ImageUrl": $imageUrl,"IsDefault": $isDefault,"IsExpired": $isExpired,"IsVenmoSdk": $isVenmoSdk,"UpdatedAt": $updatedAt,"Verification": $verification,"Bin": ${bin != null ? '${json.encode(bin)}' : 'null'},"CountryOfIssuance": ${countryOfIssuance != null ? '${json.encode(countryOfIssuance)}' : 'null'},"ExpirationDate": ${expirationDate != null ? '${json.encode(expirationDate)}' : 'null'},"ExpirationMonth": ${expirationMonth != null ? '${json.encode(expirationMonth)}' : 'null'},"ExpirationYear": ${expirationYear != null ? '${json.encode(expirationYear)}' : 'null'},"IssuingBank": ${issuingBank != null ? '${json.encode(issuingBank)}' : 'null'},"LastFour": ${lastFour != null ? '${json.encode(lastFour)}' : 'null'},"MaskedNumber": ${maskedNumber != null ? '${json.encode(maskedNumber)}' : 'null'},"ProductId": ${productId != null ? '${json.encode(productId)}' : 'null'},"Token": ${token != null ? '${json.encode(token)}' : 'null'},"UniqueNumberIdentifier": ${uniqueNumberIdentifier != null ? '${json.encode(uniqueNumberIdentifier)}' : 'null'},"Subscriptions": $subscriptions,"BillingAddress": $billingAddress,"CardType": $cardType,"Commercial": $commercial,"CustomerLocation": $customerLocation,"Debit": $debit,"DurbinRegulated": $durbinRegulated,"Healthcare": $healthcare,"Payroll": $payroll,"Prepaid": $prepaid}';
  }
}
