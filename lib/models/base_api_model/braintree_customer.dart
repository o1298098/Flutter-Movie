import 'dart:convert' show json;

import 'package:movie/models/base_api_model/braintree_subscription.dart';

import 'braintree_billing_address.dart';
import 'braintree_creditcard.dart';
import 'braintree_item_type.dart';

class BraintreeCustomer {
  Object company;
  Object customFields;
  Object email;
  Object fax;
  Object firstName;
  Object lastName;
  Object phone;
  Object website;
  String createdAt;
  String graphQLId;
  String id;
  String updatedAt;
  List<BillingAddress> addresses;
  List<dynamic> amexExpressCheckoutCards;
  List<dynamic> androidPayCards;
  List<dynamic> applePayCards;
  List<dynamic> coinbaseAccounts;
  List<CreditCard> creditCards;
  List<dynamic> masterpassCards;
  List<PayPalAccount> payPalAccounts;
  List<PaymentMethod> paymentMethods;
  List<dynamic> usBankAccounts;
  List<dynamic> venmoAccounts;
  List<dynamic> visaCheckoutCards;
  DefaultPaymentMethod defaultPaymentMethod;

  BraintreeCustomer.fromParams(
      {this.company,
      this.customFields,
      this.email,
      this.fax,
      this.firstName,
      this.lastName,
      this.phone,
      this.website,
      this.createdAt,
      this.graphQLId,
      this.id,
      this.updatedAt,
      this.addresses,
      this.amexExpressCheckoutCards,
      this.androidPayCards,
      this.applePayCards,
      this.coinbaseAccounts,
      this.creditCards,
      this.masterpassCards,
      this.payPalAccounts,
      this.paymentMethods,
      this.usBankAccounts,
      this.venmoAccounts,
      this.visaCheckoutCards,
      this.defaultPaymentMethod});

  factory BraintreeCustomer(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new BraintreeCustomer.fromJson(json.decode(jsonStr))
          : new BraintreeCustomer.fromJson(jsonStr);

  BraintreeCustomer.fromJson(jsonRes) {
    company = jsonRes['Company'];
    customFields = jsonRes['CustomFields'];
    email = jsonRes['Email'];
    fax = jsonRes['Fax'];
    firstName = jsonRes['FirstName'];
    lastName = jsonRes['LastName'];
    phone = jsonRes['Phone'];
    website = jsonRes['Website'];
    createdAt = jsonRes['CreatedAt'];
    graphQLId = jsonRes['GraphQLId'];
    id = jsonRes['Id'];
    updatedAt = jsonRes['UpdatedAt'];
    addresses = jsonRes['Addresses'] == null ? null : [];

    for (var addressesItem in addresses == null ? [] : jsonRes['Addresses']) {
      addresses.add(addressesItem == null
          ? null
          : new BillingAddress.fromJson(addressesItem));
    }

    amexExpressCheckoutCards =
        jsonRes['AmexExpressCheckoutCards'] == null ? null : [];

    for (var amexExpressCheckoutCardsItem in amexExpressCheckoutCards == null
        ? []
        : jsonRes['AmexExpressCheckoutCards']) {
      amexExpressCheckoutCards.add(amexExpressCheckoutCardsItem);
    }

    androidPayCards = jsonRes['AndroidPayCards'] == null ? null : [];

    for (var androidPayCardsItem
        in androidPayCards == null ? [] : jsonRes['AndroidPayCards']) {
      androidPayCards.add(androidPayCardsItem);
    }

    applePayCards = jsonRes['ApplePayCards'] == null ? null : [];

    for (var applePayCardsItem
        in applePayCards == null ? [] : jsonRes['ApplePayCards']) {
      applePayCards.add(applePayCardsItem);
    }

    coinbaseAccounts = jsonRes['CoinbaseAccounts'] == null ? null : [];

    for (var coinbaseAccountsItem
        in coinbaseAccounts == null ? [] : jsonRes['CoinbaseAccounts']) {
      coinbaseAccounts.add(coinbaseAccountsItem);
    }

    creditCards = jsonRes['CreditCards'] == null ? null : [];

    for (var creditCardsItem
        in creditCards == null ? [] : jsonRes['CreditCards']) {
      creditCards.add(creditCardsItem == null
          ? null
          : new CreditCard.fromJson(creditCardsItem));
    }

    masterpassCards = jsonRes['MasterpassCards'] == null ? null : [];

    for (var masterpassCardsItem
        in masterpassCards == null ? [] : jsonRes['MasterpassCards']) {
      masterpassCards.add(masterpassCardsItem);
    }

    payPalAccounts = jsonRes['PayPalAccounts'] == null ? null : [];

    for (var payPalAccountsItem
        in payPalAccounts == null ? [] : jsonRes['PayPalAccounts']) {
      payPalAccounts.add(payPalAccountsItem == null
          ? null
          : new PayPalAccount.fromJson(payPalAccountsItem));
    }

    paymentMethods = jsonRes['PaymentMethods'] == null ? null : [];

    for (var paymentMethodsItem
        in paymentMethods == null ? [] : jsonRes['PaymentMethods']) {
      paymentMethods.add(paymentMethodsItem == null
          ? null
          : new PaymentMethod.fromJson(paymentMethodsItem));
    }

    usBankAccounts = jsonRes['UsBankAccounts'] == null ? null : [];

    for (var usBankAccountsItem
        in usBankAccounts == null ? [] : jsonRes['UsBankAccounts']) {
      usBankAccounts.add(usBankAccountsItem);
    }

    venmoAccounts = jsonRes['VenmoAccounts'] == null ? null : [];

    for (var venmoAccountsItem
        in venmoAccounts == null ? [] : jsonRes['VenmoAccounts']) {
      venmoAccounts.add(venmoAccountsItem);
    }

    visaCheckoutCards = jsonRes['VisaCheckoutCards'] == null ? null : [];

    for (var visaCheckoutCardsItem
        in visaCheckoutCards == null ? [] : jsonRes['VisaCheckoutCards']) {
      visaCheckoutCards.add(visaCheckoutCardsItem);
    }

    defaultPaymentMethod = jsonRes['DefaultPaymentMethod'] == null
        ? null
        : new DefaultPaymentMethod.fromJson(jsonRes['DefaultPaymentMethod']);
  }

  @override
  String toString() {
    return '{"Company": $company,"CustomFields": $customFields,"Email": $email,"Fax": $fax,"FirstName": $firstName,"LastName": $lastName,"Phone": $phone,"Website": $website,"CreatedAt": ${createdAt != null ? '${json.encode(createdAt)}' : 'null'},"GraphQLId": ${graphQLId != null ? '${json.encode(graphQLId)}' : 'null'},"Id": ${id != null ? '${json.encode(id)}' : 'null'},"UpdatedAt": ${updatedAt != null ? '${json.encode(updatedAt)}' : 'null'},"Addresses": $addresses,"AmexExpressCheckoutCards": $amexExpressCheckoutCards,"AndroidPayCards": $androidPayCards,"ApplePayCards": $applePayCards,"CoinbaseAccounts": $coinbaseAccounts,"CreditCards": $creditCards,"MasterpassCards": $masterpassCards,"PayPalAccounts": $payPalAccounts,"PaymentMethods": $paymentMethods,"UsBankAccounts": $usBankAccounts,"VenmoAccounts": $venmoAccounts,"VisaCheckoutCards": $visaCheckoutCards,"DefaultPaymentMethod": $defaultPaymentMethod}';
  }
}

class DefaultPaymentMethod {
  Object revokedAt;
  bool isDefault;
  String billingAgreementId;
  String createdAt;
  String customerId;
  String email;
  String imageUrl;
  String payerId;
  String token;
  String updatedAt;
  List<BraintreeSubscription> subscriptions;

  DefaultPaymentMethod.fromParams(
      {this.revokedAt,
      this.isDefault,
      this.billingAgreementId,
      this.createdAt,
      this.customerId,
      this.email,
      this.imageUrl,
      this.payerId,
      this.token,
      this.updatedAt,
      this.subscriptions});

  DefaultPaymentMethod.fromJson(jsonRes) {
    revokedAt = jsonRes['RevokedAt'];
    isDefault = jsonRes['IsDefault'];
    billingAgreementId = jsonRes['BillingAgreementId'];
    createdAt = jsonRes['CreatedAt'];
    customerId = jsonRes['CustomerId'];
    email = jsonRes['Email'];
    imageUrl = jsonRes['ImageUrl'];
    payerId = jsonRes['PayerId'];
    token = jsonRes['Token'];
    updatedAt = jsonRes['UpdatedAt'];
    subscriptions = jsonRes['Subscriptions'] == null ? null : [];

    for (var subscriptionsItem
        in subscriptions == null ? [] : jsonRes['Subscriptions']) {
      subscriptions.add(BraintreeSubscription(subscriptionsItem));
    }
  }

  @override
  String toString() {
    return '{"RevokedAt": $revokedAt,"IsDefault": $isDefault,"BillingAgreementId": ${billingAgreementId != null ? '${json.encode(billingAgreementId)}' : 'null'},"CreatedAt": ${createdAt != null ? '${json.encode(createdAt)}' : 'null'},"CustomerId": ${customerId != null ? '${json.encode(customerId)}' : 'null'},"Email": ${email != null ? '${json.encode(email)}' : 'null'},"ImageUrl": ${imageUrl != null ? '${json.encode(imageUrl)}' : 'null'},"PayerId": ${payerId != null ? '${json.encode(payerId)}' : 'null'},"Token": ${token != null ? '${json.encode(token)}' : 'null'},"UpdatedAt": ${updatedAt != null ? '${json.encode(updatedAt)}' : 'null'},"Subscriptions": $subscriptions}';
  }
}

class PaymentMethod {
  Object accountType;
  Object cardholderName;
  Object revokedAt;
  bool isDefault;
  bool isExpired;
  bool isVenmoSdk;
  String billingAgreementId;
  String bin;
  String countryOfIssuance;
  String createdAt;
  String customerId;
  String email;
  String expirationDate;
  String expirationMonth;
  String expirationYear;
  String imageUrl;
  String issuingBank;
  String lastFour;
  String maskedNumber;
  String payerId;
  String productId;
  String token;
  String uniqueNumberIdentifier;
  String updatedAt;
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
  Verification verification;

  PaymentMethod.fromParams(
      {this.accountType,
      this.cardholderName,
      this.revokedAt,
      this.isDefault,
      this.isExpired,
      this.isVenmoSdk,
      this.billingAgreementId,
      this.bin,
      this.countryOfIssuance,
      this.createdAt,
      this.customerId,
      this.email,
      this.expirationDate,
      this.expirationMonth,
      this.expirationYear,
      this.imageUrl,
      this.issuingBank,
      this.lastFour,
      this.maskedNumber,
      this.payerId,
      this.productId,
      this.token,
      this.uniqueNumberIdentifier,
      this.updatedAt,
      this.subscriptions,
      this.billingAddress,
      this.cardType,
      this.commercial,
      this.customerLocation,
      this.debit,
      this.durbinRegulated,
      this.healthcare,
      this.payroll,
      this.prepaid,
      this.verification});

  PaymentMethod.fromJson(jsonRes) {
    accountType = jsonRes['AccountType'];
    cardholderName = jsonRes['CardholderName'];
    revokedAt = jsonRes['RevokedAt'];
    isDefault = jsonRes['IsDefault'];
    isExpired = jsonRes['IsExpired'];
    isVenmoSdk = jsonRes['IsVenmoSdk'];
    billingAgreementId = jsonRes['BillingAgreementId'];
    bin = jsonRes['Bin'];
    countryOfIssuance = jsonRes['CountryOfIssuance'];
    createdAt = jsonRes['CreatedAt'];
    customerId = jsonRes['CustomerId'];
    email = jsonRes['Email'];
    expirationDate = jsonRes['ExpirationDate'];
    expirationMonth = jsonRes['ExpirationMonth'];
    expirationYear = jsonRes['ExpirationYear'];
    imageUrl = jsonRes['ImageUrl'];
    issuingBank = jsonRes['IssuingBank'];
    lastFour = jsonRes['LastFour'];
    maskedNumber = jsonRes['MaskedNumber'];
    payerId = jsonRes['PayerId'];
    productId = jsonRes['ProductId'];
    token = jsonRes['Token'];
    uniqueNumberIdentifier = jsonRes['UniqueNumberIdentifier'];
    updatedAt = jsonRes['UpdatedAt'];
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
    verification = jsonRes['Verification'] == null
        ? null
        : new Verification.fromJson(jsonRes['Verification']);
  }

  @override
  String toString() {
    return '{"AccountType": $accountType,"CardholderName": $cardholderName,"RevokedAt": $revokedAt,"IsDefault": $isDefault,"IsExpired": $isExpired,"IsVenmoSdk": $isVenmoSdk,"BillingAgreementId": ${billingAgreementId != null ? '${json.encode(billingAgreementId)}' : 'null'},"Bin": ${bin != null ? '${json.encode(bin)}' : 'null'},"CountryOfIssuance": ${countryOfIssuance != null ? '${json.encode(countryOfIssuance)}' : 'null'},"CreatedAt": ${createdAt != null ? '${json.encode(createdAt)}' : 'null'},"CustomerId": ${customerId != null ? '${json.encode(customerId)}' : 'null'},"Email": ${email != null ? '${json.encode(email)}' : 'null'},"ExpirationDate": ${expirationDate != null ? '${json.encode(expirationDate)}' : 'null'},"ExpirationMonth": ${expirationMonth != null ? '${json.encode(expirationMonth)}' : 'null'},"ExpirationYear": ${expirationYear != null ? '${json.encode(expirationYear)}' : 'null'},"ImageUrl": ${imageUrl != null ? '${json.encode(imageUrl)}' : 'null'},"IssuingBank": ${issuingBank != null ? '${json.encode(issuingBank)}' : 'null'},"LastFour": ${lastFour != null ? '${json.encode(lastFour)}' : 'null'},"MaskedNumber": ${maskedNumber != null ? '${json.encode(maskedNumber)}' : 'null'},"PayerId": ${payerId != null ? '${json.encode(payerId)}' : 'null'},"ProductId": ${productId != null ? '${json.encode(productId)}' : 'null'},"Token": ${token != null ? '${json.encode(token)}' : 'null'},"UniqueNumberIdentifier": ${uniqueNumberIdentifier != null ? '${json.encode(uniqueNumberIdentifier)}' : 'null'},"UpdatedAt": ${updatedAt != null ? '${json.encode(updatedAt)}' : 'null'},"Subscriptions": $subscriptions,"BillingAddress": $billingAddress,"CardType": $cardType,"Commercial": $commercial,"CustomerLocation": $customerLocation,"Debit": $debit,"DurbinRegulated": $durbinRegulated,"Healthcare": $healthcare,"Payroll": $payroll,"Prepaid": $prepaid,"Verification": $verification}';
  }
}

class Verification {
  Object avsErrorResponseCode;
  Object gatewayRejectionReason;
  Object riskData;
  Object threeDSecureInfo;
  double amount;
  String avsPostalCodeResponseCode;
  String avsStreetAddressResponseCode;
  String createdAt;
  String currencyIsoCode;
  String cvvResponseCode;
  String graphQLId;
  String id;
  String merchantAccountId;
  String networkResponseCode;
  String networkResponseText;
  String processorResponseCode;
  String processorResponseText;
  BillingAddress billingAddress;
  CreditCard creditCard;
  ItemType processorResponseType;
  ItemType status;

  Verification.fromParams(
      {this.avsErrorResponseCode,
      this.gatewayRejectionReason,
      this.riskData,
      this.threeDSecureInfo,
      this.amount,
      this.avsPostalCodeResponseCode,
      this.avsStreetAddressResponseCode,
      this.createdAt,
      this.currencyIsoCode,
      this.cvvResponseCode,
      this.graphQLId,
      this.id,
      this.merchantAccountId,
      this.networkResponseCode,
      this.networkResponseText,
      this.processorResponseCode,
      this.processorResponseText,
      this.billingAddress,
      this.creditCard,
      this.processorResponseType,
      this.status});

  Verification.fromJson(jsonRes) {
    avsErrorResponseCode = jsonRes['AvsErrorResponseCode'];
    gatewayRejectionReason = jsonRes['GatewayRejectionReason'];
    riskData = jsonRes['RiskData'];
    threeDSecureInfo = jsonRes['ThreeDSecureInfo'];
    amount = jsonRes['Amount'];
    avsPostalCodeResponseCode = jsonRes['AvsPostalCodeResponseCode'];
    avsStreetAddressResponseCode = jsonRes['AvsStreetAddressResponseCode'];
    createdAt = jsonRes['CreatedAt'];
    currencyIsoCode = jsonRes['CurrencyIsoCode'];
    cvvResponseCode = jsonRes['CvvResponseCode'];
    graphQLId = jsonRes['GraphQLId'];
    id = jsonRes['Id'];
    merchantAccountId = jsonRes['MerchantAccountId'];
    networkResponseCode = jsonRes['NetworkResponseCode'];
    networkResponseText = jsonRes['NetworkResponseText'];
    processorResponseCode = jsonRes['ProcessorResponseCode'];
    processorResponseText = jsonRes['ProcessorResponseText'];
    billingAddress = jsonRes['BillingAddress'] == null
        ? null
        : new BillingAddress.fromJson(jsonRes['BillingAddress']);
    creditCard = jsonRes['CreditCard'] == null
        ? null
        : new CreditCard.fromJson(jsonRes['CreditCard']);
    processorResponseType = jsonRes['ProcessorResponseType'] == null
        ? null
        : new ItemType.fromJson(jsonRes['ProcessorResponseType']);
    status = jsonRes['Status'] == null
        ? null
        : new ItemType.fromJson(jsonRes['Status']);
  }

  @override
  String toString() {
    return '{"AvsErrorResponseCode": $avsErrorResponseCode,"GatewayRejectionReason": $gatewayRejectionReason,"RiskData": $riskData,"ThreeDSecureInfo": $threeDSecureInfo,"Amount": $amount,"AvsPostalCodeResponseCode": ${avsPostalCodeResponseCode != null ? '${json.encode(avsPostalCodeResponseCode)}' : 'null'},"AvsStreetAddressResponseCode": ${avsStreetAddressResponseCode != null ? '${json.encode(avsStreetAddressResponseCode)}' : 'null'},"CreatedAt": ${createdAt != null ? '${json.encode(createdAt)}' : 'null'},"CurrencyIsoCode": ${currencyIsoCode != null ? '${json.encode(currencyIsoCode)}' : 'null'},"CvvResponseCode": ${cvvResponseCode != null ? '${json.encode(cvvResponseCode)}' : 'null'},"GraphQLId": ${graphQLId != null ? '${json.encode(graphQLId)}' : 'null'},"Id": ${id != null ? '${json.encode(id)}' : 'null'},"MerchantAccountId": ${merchantAccountId != null ? '${json.encode(merchantAccountId)}' : 'null'},"NetworkResponseCode": ${networkResponseCode != null ? '${json.encode(networkResponseCode)}' : 'null'},"NetworkResponseText": ${networkResponseText != null ? '${json.encode(networkResponseText)}' : 'null'},"ProcessorResponseCode": ${processorResponseCode != null ? '${json.encode(processorResponseCode)}' : 'null'},"ProcessorResponseText": ${processorResponseText != null ? '${json.encode(processorResponseText)}' : 'null'},"BillingAddress": $billingAddress,"CreditCard": $creditCard,"ProcessorResponseType": $processorResponseType,"Status": $status}';
  }
}

class PayPalAccount {
  Object revokedAt;
  bool isDefault;
  String billingAgreementId;
  String createdAt;
  String customerId;
  String email;
  String imageUrl;
  String payerId;
  String token;
  String updatedAt;
  List<BraintreeSubscription> subscriptions;

  PayPalAccount.fromParams(
      {this.revokedAt,
      this.isDefault,
      this.billingAgreementId,
      this.createdAt,
      this.customerId,
      this.email,
      this.imageUrl,
      this.payerId,
      this.token,
      this.updatedAt,
      this.subscriptions});

  PayPalAccount.fromJson(jsonRes) {
    revokedAt = jsonRes['RevokedAt'];
    isDefault = jsonRes['IsDefault'];
    billingAgreementId = jsonRes['BillingAgreementId'];
    createdAt = jsonRes['CreatedAt'];
    customerId = jsonRes['CustomerId'];
    email = jsonRes['Email'];
    imageUrl = jsonRes['ImageUrl'];
    payerId = jsonRes['PayerId'];
    token = jsonRes['Token'];
    updatedAt = jsonRes['UpdatedAt'];
    subscriptions = jsonRes['Subscriptions'] == null ? null : [];

    for (var subscriptionsItem
        in subscriptions == null ? [] : jsonRes['Subscriptions']) {
      subscriptions.add(BraintreeSubscription(subscriptionsItem));
    }
  }

  @override
  String toString() {
    return '{"RevokedAt": $revokedAt,"IsDefault": $isDefault,"BillingAgreementId": ${billingAgreementId != null ? '${json.encode(billingAgreementId)}' : 'null'},"CreatedAt": ${createdAt != null ? '${json.encode(createdAt)}' : 'null'},"CustomerId": ${customerId != null ? '${json.encode(customerId)}' : 'null'},"Email": ${email != null ? '${json.encode(email)}' : 'null'},"ImageUrl": ${imageUrl != null ? '${json.encode(imageUrl)}' : 'null'},"PayerId": ${payerId != null ? '${json.encode(payerId)}' : 'null'},"Token": ${token != null ? '${json.encode(token)}' : 'null'},"UpdatedAt": ${updatedAt != null ? '${json.encode(updatedAt)}' : 'null'},"Subscriptions": $subscriptions}';
  }
}
