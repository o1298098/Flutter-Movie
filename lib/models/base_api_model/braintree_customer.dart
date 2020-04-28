import 'dart:convert' show json;

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
  List<ExtendedAddress> addresses;
  List<dynamic> amexExpressCheckoutCards;
  List<dynamic> androidPayCards;
  List<dynamic> applePayCards;
  List<dynamic> coinbaseAccounts;
  List<AccountType> creditCards;
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
    company = jsonRes['company'];
    customFields = jsonRes['customFields'];
    email = jsonRes['email'];
    fax = jsonRes['fax'];
    firstName = jsonRes['firstName'];
    lastName = jsonRes['lastName'];
    phone = jsonRes['phone'];
    website = jsonRes['website'];
    createdAt = jsonRes['createdAt'];
    graphQLId = jsonRes['graphQLId'];
    id = jsonRes['id'];
    updatedAt = jsonRes['updatedAt'];
    addresses = jsonRes['addresses'] == null ? null : [];

    for (var addressesItem in addresses == null ? [] : jsonRes['addresses']) {
      addresses.add(addressesItem == null
          ? null
          : new ExtendedAddress.fromJson(addressesItem));
    }

    amexExpressCheckoutCards =
        jsonRes['amexExpressCheckoutCards'] == null ? null : [];

    for (var amexExpressCheckoutCardsItem in amexExpressCheckoutCards == null
        ? []
        : jsonRes['amexExpressCheckoutCards']) {
      amexExpressCheckoutCards.add(amexExpressCheckoutCardsItem);
    }

    androidPayCards = jsonRes['androidPayCards'] == null ? null : [];

    for (var androidPayCardsItem
        in androidPayCards == null ? [] : jsonRes['androidPayCards']) {
      androidPayCards.add(androidPayCardsItem);
    }

    applePayCards = jsonRes['applePayCards'] == null ? null : [];

    for (var applePayCardsItem
        in applePayCards == null ? [] : jsonRes['applePayCards']) {
      applePayCards.add(applePayCardsItem);
    }

    coinbaseAccounts = jsonRes['coinbaseAccounts'] == null ? null : [];

    for (var coinbaseAccountsItem
        in coinbaseAccounts == null ? [] : jsonRes['coinbaseAccounts']) {
      coinbaseAccounts.add(coinbaseAccountsItem);
    }

    creditCards = jsonRes['creditCards'] == null ? null : [];

    for (var creditCardsItem
        in creditCards == null ? [] : jsonRes['creditCards']) {
      creditCards.add(creditCardsItem == null
          ? null
          : new AccountType.fromJson(creditCardsItem));
    }

    masterpassCards = jsonRes['masterpassCards'] == null ? null : [];

    for (var masterpassCardsItem
        in masterpassCards == null ? [] : jsonRes['masterpassCards']) {
      masterpassCards.add(masterpassCardsItem);
    }

    payPalAccounts = jsonRes['payPalAccounts'] == null ? null : [];

    for (var payPalAccountsItem
        in payPalAccounts == null ? [] : jsonRes['payPalAccounts']) {
      payPalAccounts.add(payPalAccountsItem == null
          ? null
          : new PayPalAccount.fromJson(payPalAccountsItem));
    }

    paymentMethods = jsonRes['paymentMethods'] == null ? null : [];

    for (var paymentMethodsItem
        in paymentMethods == null ? [] : jsonRes['paymentMethods']) {
      paymentMethods.add(paymentMethodsItem == null
          ? null
          : new PaymentMethod.fromJson(paymentMethodsItem));
    }

    usBankAccounts = jsonRes['usBankAccounts'] == null ? null : [];

    for (var usBankAccountsItem
        in usBankAccounts == null ? [] : jsonRes['usBankAccounts']) {
      usBankAccounts.add(usBankAccountsItem);
    }

    venmoAccounts = jsonRes['venmoAccounts'] == null ? null : [];

    for (var venmoAccountsItem
        in venmoAccounts == null ? [] : jsonRes['venmoAccounts']) {
      venmoAccounts.add(venmoAccountsItem);
    }

    visaCheckoutCards = jsonRes['visaCheckoutCards'] == null ? null : [];

    for (var visaCheckoutCardsItem
        in visaCheckoutCards == null ? [] : jsonRes['visaCheckoutCards']) {
      visaCheckoutCards.add(visaCheckoutCardsItem);
    }

    defaultPaymentMethod = jsonRes['defaultPaymentMethod'] == null
        ? null
        : new DefaultPaymentMethod.fromJson(jsonRes['defaultPaymentMethod']);
  }

  @override
  String toString() {
    return '{"company": $company,"customFields": $customFields,"email": $email,"fax": $fax,"firstName": $firstName,"lastName": $lastName,"phone": $phone,"website": $website,"createdAt": ${createdAt != null ? '${json.encode(createdAt)}' : 'null'},"graphQLId": ${graphQLId != null ? '${json.encode(graphQLId)}' : 'null'},"id": ${id != null ? '${json.encode(id)}' : 'null'},"updatedAt": ${updatedAt != null ? '${json.encode(updatedAt)}' : 'null'},"addresses": $addresses,"amexExpressCheckoutCards": $amexExpressCheckoutCards,"androidPayCards": $androidPayCards,"applePayCards": $applePayCards,"coinbaseAccounts": $coinbaseAccounts,"creditCards": $creditCards,"masterpassCards": $masterpassCards,"payPalAccounts": $payPalAccounts,"paymentMethods": $paymentMethods,"usBankAccounts": $usBankAccounts,"venmoAccounts": $venmoAccounts,"visaCheckoutCards": $visaCheckoutCards,"defaultPaymentMethod": $defaultPaymentMethod}';
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
  List<dynamic> subscriptions;

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
    revokedAt = jsonRes['revokedAt'];
    isDefault = jsonRes['isDefault'];
    billingAgreementId = jsonRes['billingAgreementId'];
    createdAt = jsonRes['createdAt'];
    customerId = jsonRes['customerId'];
    email = jsonRes['email'];
    imageUrl = jsonRes['imageUrl'];
    payerId = jsonRes['payerId'];
    token = jsonRes['token'];
    updatedAt = jsonRes['updatedAt'];
    subscriptions = jsonRes['subscriptions'] == null ? null : [];

    for (var subscriptionsItem
        in subscriptions == null ? [] : jsonRes['subscriptions']) {
      subscriptions.add(subscriptionsItem);
    }
  }

  @override
  String toString() {
    return '{"revokedAt": $revokedAt,"isDefault": $isDefault,"billingAgreementId": ${billingAgreementId != null ? '${json.encode(billingAgreementId)}' : 'null'},"createdAt": ${createdAt != null ? '${json.encode(createdAt)}' : 'null'},"customerId": ${customerId != null ? '${json.encode(customerId)}' : 'null'},"email": ${email != null ? '${json.encode(email)}' : 'null'},"imageUrl": ${imageUrl != null ? '${json.encode(imageUrl)}' : 'null'},"payerId": ${payerId != null ? '${json.encode(payerId)}' : 'null'},"token": ${token != null ? '${json.encode(token)}' : 'null'},"updatedAt": ${updatedAt != null ? '${json.encode(updatedAt)}' : 'null'},"subscriptions": $subscriptions}';
  }
}

class PaymentMethod {
  Object accountType;
  Object cardType;
  Object cardholderName;
  Object commercial;
  Object customerLocation;
  Object debit;
  Object durbinRegulated;
  Object healthcare;
  Object payroll;
  Object prepaid;
  Object revokedAt;
  Object verification;
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
  List<dynamic> subscriptions;
  BillingAddress billingAddress;

  PaymentMethod.fromParams(
      {this.accountType,
      this.cardType,
      this.cardholderName,
      this.commercial,
      this.customerLocation,
      this.debit,
      this.durbinRegulated,
      this.healthcare,
      this.payroll,
      this.prepaid,
      this.revokedAt,
      this.verification,
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
      this.billingAddress});

  PaymentMethod.fromJson(jsonRes) {
    accountType = jsonRes['accountType'];
    cardType = jsonRes['cardType'];
    cardholderName = jsonRes['cardholderName'];
    commercial = jsonRes['commercial'];
    customerLocation = jsonRes['customerLocation'];
    debit = jsonRes['debit'];
    durbinRegulated = jsonRes['durbinRegulated'];
    healthcare = jsonRes['healthcare'];
    payroll = jsonRes['payroll'];
    prepaid = jsonRes['prepaid'];
    revokedAt = jsonRes['revokedAt'];
    verification = jsonRes['verification'];
    isDefault = jsonRes['isDefault'];
    isExpired = jsonRes['isExpired'];
    isVenmoSdk = jsonRes['isVenmoSdk'];
    billingAgreementId = jsonRes['billingAgreementId'];
    bin = jsonRes['bin'];
    countryOfIssuance = jsonRes['countryOfIssuance'];
    createdAt = jsonRes['createdAt'];
    customerId = jsonRes['customerId'];
    email = jsonRes['email'];
    expirationDate = jsonRes['expirationDate'];
    expirationMonth = jsonRes['expirationMonth'];
    expirationYear = jsonRes['expirationYear'];
    imageUrl = jsonRes['imageUrl'];
    issuingBank = jsonRes['issuingBank'];
    lastFour = jsonRes['lastFour'];
    maskedNumber = jsonRes['maskedNumber'];
    payerId = jsonRes['payerId'];
    productId = jsonRes['productId'];
    token = jsonRes['token'];
    uniqueNumberIdentifier = jsonRes['uniqueNumberIdentifier'];
    updatedAt = jsonRes['updatedAt'];
    subscriptions = jsonRes['subscriptions'] == null ? null : [];

    for (var subscriptionsItem
        in subscriptions == null ? [] : jsonRes['subscriptions']) {
      subscriptions.add(subscriptionsItem);
    }

    billingAddress = jsonRes['billingAddress'] == null
        ? null
        : new BillingAddress.fromJson(jsonRes['billingAddress']);
  }

  @override
  String toString() {
    return '{"accountType": $accountType,"cardType": $cardType,"cardholderName": $cardholderName,"commercial": $commercial,"customerLocation": $customerLocation,"debit": $debit,"durbinRegulated": $durbinRegulated,"healthcare": $healthcare,"payroll": $payroll,"prepaid": $prepaid,"revokedAt": $revokedAt,"verification": $verification,"isDefault": $isDefault,"isExpired": $isExpired,"isVenmoSdk": $isVenmoSdk,"billingAgreementId": ${billingAgreementId != null ? '${json.encode(billingAgreementId)}' : 'null'},"bin": ${bin != null ? '${json.encode(bin)}' : 'null'},"countryOfIssuance": ${countryOfIssuance != null ? '${json.encode(countryOfIssuance)}' : 'null'},"createdAt": ${createdAt != null ? '${json.encode(createdAt)}' : 'null'},"customerId": ${customerId != null ? '${json.encode(customerId)}' : 'null'},"email": ${email != null ? '${json.encode(email)}' : 'null'},"expirationDate": ${expirationDate != null ? '${json.encode(expirationDate)}' : 'null'},"expirationMonth": ${expirationMonth != null ? '${json.encode(expirationMonth)}' : 'null'},"expirationYear": ${expirationYear != null ? '${json.encode(expirationYear)}' : 'null'},"imageUrl": ${imageUrl != null ? '${json.encode(imageUrl)}' : 'null'},"issuingBank": ${issuingBank != null ? '${json.encode(issuingBank)}' : 'null'},"lastFour": ${lastFour != null ? '${json.encode(lastFour)}' : 'null'},"maskedNumber": ${maskedNumber != null ? '${json.encode(maskedNumber)}' : 'null'},"payerId": ${payerId != null ? '${json.encode(payerId)}' : 'null'},"productId": ${productId != null ? '${json.encode(productId)}' : 'null'},"token": ${token != null ? '${json.encode(token)}' : 'null'},"uniqueNumberIdentifier": ${uniqueNumberIdentifier != null ? '${json.encode(uniqueNumberIdentifier)}' : 'null'},"updatedAt": ${updatedAt != null ? '${json.encode(updatedAt)}' : 'null'},"subscriptions": $subscriptions,"billingAddress": $billingAddress}';
  }
}

class BillingAddress {
  Object company;
  Object countryCodeAlpha2;
  Object countryCodeAlpha3;
  Object countryCodeNumeric;
  Object countryName;
  Object createdAt;
  Object customerId;
  Object extendedAddress;
  Object firstName;
  Object id;
  Object lastName;
  Object locality;
  Object postalCode;
  Object region;
  Object streetAddress;
  Object updatedAt;

  BillingAddress.fromParams(
      {this.company,
      this.countryCodeAlpha2,
      this.countryCodeAlpha3,
      this.countryCodeNumeric,
      this.countryName,
      this.createdAt,
      this.customerId,
      this.extendedAddress,
      this.firstName,
      this.id,
      this.lastName,
      this.locality,
      this.postalCode,
      this.region,
      this.streetAddress,
      this.updatedAt});

  BillingAddress.fromJson(jsonRes) {
    company = jsonRes['company'];
    countryCodeAlpha2 = jsonRes['countryCodeAlpha2'];
    countryCodeAlpha3 = jsonRes['countryCodeAlpha3'];
    countryCodeNumeric = jsonRes['countryCodeNumeric'];
    countryName = jsonRes['countryName'];
    createdAt = jsonRes['createdAt'];
    customerId = jsonRes['customerId'];
    extendedAddress = jsonRes['extendedAddress'];
    firstName = jsonRes['firstName'];
    id = jsonRes['id'];
    lastName = jsonRes['lastName'];
    locality = jsonRes['locality'];
    postalCode = jsonRes['postalCode'];
    region = jsonRes['region'];
    streetAddress = jsonRes['streetAddress'];
    updatedAt = jsonRes['updatedAt'];
  }

  @override
  String toString() {
    return '{"company": $company,"countryCodeAlpha2": $countryCodeAlpha2,"countryCodeAlpha3": $countryCodeAlpha3,"countryCodeNumeric": $countryCodeNumeric,"countryName": $countryName,"createdAt": $createdAt,"customerId": $customerId,"extendedAddress": $extendedAddress,"firstName": $firstName,"id": $id,"lastName": $lastName,"locality": $locality,"postalCode": $postalCode,"region": $region,"streetAddress": $streetAddress,"updatedAt": $updatedAt}';
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
  List<List<PaymentMethod>> subscriptions;

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
    revokedAt = jsonRes['revokedAt'];
    isDefault = jsonRes['isDefault'];
    billingAgreementId = jsonRes['billingAgreementId'];
    createdAt = jsonRes['createdAt'];
    customerId = jsonRes['customerId'];
    email = jsonRes['email'];
    imageUrl = jsonRes['imageUrl'];
    payerId = jsonRes['payerId'];
    token = jsonRes['token'];
    updatedAt = jsonRes['updatedAt'];
    subscriptions = jsonRes['subscriptions'] == null ? null : [];

    for (var subscriptionsItem
        in subscriptions == null ? [] : jsonRes['subscriptions']) {
      List<PaymentMethod> subscriptionsChild =
          subscriptionsItem == null ? null : [];
      for (var subscriptionsItemItem
          in subscriptionsChild == null ? [] : subscriptionsItem) {
        subscriptionsChild.add(subscriptionsItemItem == null
            ? null
            : new PaymentMethod.fromJson(subscriptionsItemItem));
      }
      subscriptions.add(subscriptionsChild);
    }
  }

  @override
  String toString() {
    return '{"revokedAt": $revokedAt,"isDefault": $isDefault,"billingAgreementId": ${billingAgreementId != null ? '${json.encode(billingAgreementId)}' : 'null'},"createdAt": ${createdAt != null ? '${json.encode(createdAt)}' : 'null'},"customerId": ${customerId != null ? '${json.encode(customerId)}' : 'null'},"email": ${email != null ? '${json.encode(email)}' : 'null'},"imageUrl": ${imageUrl != null ? '${json.encode(imageUrl)}' : 'null'},"payerId": ${payerId != null ? '${json.encode(payerId)}' : 'null'},"token": ${token != null ? '${json.encode(token)}' : 'null'},"updatedAt": ${updatedAt != null ? '${json.encode(updatedAt)}' : 'null'},"subscriptions": $subscriptions}';
  }
}

class AccountType {
  Object accountType;
  Object cardType;
  Object cardholderName;
  Object commercial;
  Object customerLocation;
  Object debit;
  Object durbinRegulated;
  Object healthcare;
  Object payroll;
  Object prepaid;
  Object verification;
  bool isDefault;
  bool isExpired;
  bool isVenmoSdk;
  String bin;
  String countryOfIssuance;
  String createdAt;
  String customerId;
  String expirationDate;
  String expirationMonth;
  String expirationYear;
  String imageUrl;
  String issuingBank;
  String lastFour;
  String maskedNumber;
  String productId;
  String token;
  String uniqueNumberIdentifier;
  String updatedAt;
  List<dynamic> subscriptions;
  BillingAddress billingAddress;

  AccountType.fromParams(
      {this.accountType,
      this.cardType,
      this.cardholderName,
      this.commercial,
      this.customerLocation,
      this.debit,
      this.durbinRegulated,
      this.healthcare,
      this.payroll,
      this.prepaid,
      this.verification,
      this.isDefault,
      this.isExpired,
      this.isVenmoSdk,
      this.bin,
      this.countryOfIssuance,
      this.createdAt,
      this.customerId,
      this.expirationDate,
      this.expirationMonth,
      this.expirationYear,
      this.imageUrl,
      this.issuingBank,
      this.lastFour,
      this.maskedNumber,
      this.productId,
      this.token,
      this.uniqueNumberIdentifier,
      this.updatedAt,
      this.subscriptions,
      this.billingAddress});

  AccountType.fromJson(jsonRes) {
    accountType = jsonRes['accountType'];
    cardType = jsonRes['cardType'];
    cardholderName = jsonRes['cardholderName'];
    commercial = jsonRes['commercial'];
    customerLocation = jsonRes['customerLocation'];
    debit = jsonRes['debit'];
    durbinRegulated = jsonRes['durbinRegulated'];
    healthcare = jsonRes['healthcare'];
    payroll = jsonRes['payroll'];
    prepaid = jsonRes['prepaid'];
    verification = jsonRes['verification'];
    isDefault = jsonRes['isDefault'];
    isExpired = jsonRes['isExpired'];
    isVenmoSdk = jsonRes['isVenmoSdk'];
    bin = jsonRes['bin'];
    countryOfIssuance = jsonRes['countryOfIssuance'];
    createdAt = jsonRes['createdAt'];
    customerId = jsonRes['customerId'];
    expirationDate = jsonRes['expirationDate'];
    expirationMonth = jsonRes['expirationMonth'];
    expirationYear = jsonRes['expirationYear'];
    imageUrl = jsonRes['imageUrl'];
    issuingBank = jsonRes['issuingBank'];
    lastFour = jsonRes['lastFour'];
    maskedNumber = jsonRes['maskedNumber'];
    productId = jsonRes['productId'];
    token = jsonRes['token'];
    uniqueNumberIdentifier = jsonRes['uniqueNumberIdentifier'];
    updatedAt = jsonRes['updatedAt'];
    subscriptions = jsonRes['subscriptions'] == null ? null : [];

    for (var subscriptionsItem
        in subscriptions == null ? [] : jsonRes['subscriptions']) {
      subscriptions.add(subscriptionsItem);
    }

    billingAddress = jsonRes['billingAddress'] == null
        ? null
        : new BillingAddress.fromJson(jsonRes['billingAddress']);
  }

  @override
  String toString() {
    return '{"accountType": $accountType,"cardType": $cardType,"cardholderName": $cardholderName,"commercial": $commercial,"customerLocation": $customerLocation,"debit": $debit,"durbinRegulated": $durbinRegulated,"healthcare": $healthcare,"payroll": $payroll,"prepaid": $prepaid,"verification": $verification,"isDefault": $isDefault,"isExpired": $isExpired,"isVenmoSdk": $isVenmoSdk,"bin": ${bin != null ? '${json.encode(bin)}' : 'null'},"countryOfIssuance": ${countryOfIssuance != null ? '${json.encode(countryOfIssuance)}' : 'null'},"createdAt": ${createdAt != null ? '${json.encode(createdAt)}' : 'null'},"customerId": ${customerId != null ? '${json.encode(customerId)}' : 'null'},"expirationDate": ${expirationDate != null ? '${json.encode(expirationDate)}' : 'null'},"expirationMonth": ${expirationMonth != null ? '${json.encode(expirationMonth)}' : 'null'},"expirationYear": ${expirationYear != null ? '${json.encode(expirationYear)}' : 'null'},"imageUrl": ${imageUrl != null ? '${json.encode(imageUrl)}' : 'null'},"issuingBank": ${issuingBank != null ? '${json.encode(issuingBank)}' : 'null'},"lastFour": ${lastFour != null ? '${json.encode(lastFour)}' : 'null'},"maskedNumber": ${maskedNumber != null ? '${json.encode(maskedNumber)}' : 'null'},"productId": ${productId != null ? '${json.encode(productId)}' : 'null'},"token": ${token != null ? '${json.encode(token)}' : 'null'},"uniqueNumberIdentifier": ${uniqueNumberIdentifier != null ? '${json.encode(uniqueNumberIdentifier)}' : 'null'},"updatedAt": ${updatedAt != null ? '${json.encode(updatedAt)}' : 'null'},"subscriptions": $subscriptions,"billingAddress": $billingAddress}';
  }
}

class ExtendedAddress {
  Object extendedAddress;
  String company;
  String countryCodeAlpha2;
  String countryCodeAlpha3;
  String countryCodeNumeric;
  String countryName;
  String createdAt;
  String customerId;
  String firstName;
  String id;
  String lastName;
  String locality;
  String postalCode;
  String region;
  String streetAddress;
  String updatedAt;

  ExtendedAddress.fromParams(
      {this.extendedAddress,
      this.company,
      this.countryCodeAlpha2,
      this.countryCodeAlpha3,
      this.countryCodeNumeric,
      this.countryName,
      this.createdAt,
      this.customerId,
      this.firstName,
      this.id,
      this.lastName,
      this.locality,
      this.postalCode,
      this.region,
      this.streetAddress,
      this.updatedAt});

  ExtendedAddress.fromJson(jsonRes) {
    extendedAddress = jsonRes['extendedAddress'];
    company = jsonRes['company'];
    countryCodeAlpha2 = jsonRes['countryCodeAlpha2'];
    countryCodeAlpha3 = jsonRes['countryCodeAlpha3'];
    countryCodeNumeric = jsonRes['countryCodeNumeric'];
    countryName = jsonRes['countryName'];
    createdAt = jsonRes['createdAt'];
    customerId = jsonRes['customerId'];
    firstName = jsonRes['firstName'];
    id = jsonRes['id'];
    lastName = jsonRes['lastName'];
    locality = jsonRes['locality'];
    postalCode = jsonRes['postalCode'];
    region = jsonRes['region'];
    streetAddress = jsonRes['streetAddress'];
    updatedAt = jsonRes['updatedAt'];
  }

  @override
  String toString() {
    return '{"extendedAddress": $extendedAddress,"company": ${company != null ? '${json.encode(company)}' : 'null'},"countryCodeAlpha2": ${countryCodeAlpha2 != null ? '${json.encode(countryCodeAlpha2)}' : 'null'},"countryCodeAlpha3": ${countryCodeAlpha3 != null ? '${json.encode(countryCodeAlpha3)}' : 'null'},"countryCodeNumeric": ${countryCodeNumeric != null ? '${json.encode(countryCodeNumeric)}' : 'null'},"countryName": ${countryName != null ? '${json.encode(countryName)}' : 'null'},"createdAt": ${createdAt != null ? '${json.encode(createdAt)}' : 'null'},"customerId": ${customerId != null ? '${json.encode(customerId)}' : 'null'},"firstName": ${firstName != null ? '${json.encode(firstName)}' : 'null'},"id": ${id != null ? '${json.encode(id)}' : 'null'},"lastName": ${lastName != null ? '${json.encode(lastName)}' : 'null'},"locality": ${locality != null ? '${json.encode(locality)}' : 'null'},"postalCode": ${postalCode != null ? '${json.encode(postalCode)}' : 'null'},"region": ${region != null ? '${json.encode(region)}' : 'null'},"streetAddress": ${streetAddress != null ? '${json.encode(streetAddress)}' : 'null'},"updatedAt": ${updatedAt != null ? '${json.encode(updatedAt)}' : 'null'}}';
  }
}
