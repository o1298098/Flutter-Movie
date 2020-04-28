import 'dart:convert' show json;

class TransactionModel {
  List<Transaction> list;

  TransactionModel.fromParams({this.list});

  factory TransactionModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new TransactionModel.fromJson(json.decode(jsonStr))
          : new TransactionModel.fromJson(jsonStr);

  TransactionModel.fromJson(jsonRes) {
    list = jsonRes == null ? null : [];

    for (var listItem in list == null ? [] : jsonRes) {
      list.add(listItem == null ? null : new Transaction.fromJson(listItem));
    }
  }

  @override
  String toString() {
    return '{"json_list": $list}';
  }
}

class Transaction {
  Object additionalProcessorResponse;
  Object amexExpressCheckoutDetails;
  Object applePayDetails;
  Object authorizedTransactionId;
  Object avsErrorResponseCode;
  Object channel;
  Object coinbaseDetails;
  Object customFields;
  Object discountAmount;
  Object escrowStatus;
  Object facilitatedDetails;
  Object facilitatorDetails;
  Object gatewayRejectionReason;
  Object idealPaymentDetails;
  Object localPaymentDetails;
  Object masterpassCardDetails;
  Object orderId;
  Object payPalHereDetails;
  Object paymentInstrumentType;
  Object planId;
  Object processorResponseType;
  Object purchaseOrderNumber;
  Object refundedTransactionId;
  Object riskData;
  Object samsungPayCardDetails;
  Object serviceFeeAmount;
  Object shippingAmount;
  Object shipsFromPostalCode;
  Object status;
  Object subscriptionId;
  Object taxAmount;
  Object threeDSecureInfo;
  Object type;
  Object usBankAccountDetails;
  Object venmoAccountDetails;
  Object visaCheckoutCardDetails;
  Object voiceReferralNumber;
  double amount;
  bool recurring;
  bool taxExempt;
  String authorizationExpiresAt;
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
  String networkTransactionId;
  String processorAuthorizationCode;
  String processorResponseCode;
  String processorResponseText;
  String processorSettlementResponseCode;
  String processorSettlementResponseText;
  String settlementBatchId;
  String updatedAt;
  List<dynamic> addOns;
  List<dynamic> authorizationAdjustments;
  List<dynamic> discounts;
  List<dynamic> disputes;
  List<dynamic> partialSettlementTransactionIds;
  List<dynamic> refundIds;
  List<StatusHistory> statusHistory;
  AndroidPayDetails androidPayDetails;
  BillingAddress billingAddress;
  CreditCard creditCard;
  CustomerDetails customerDetails;
  Descriptor descriptor;
  DisbursementDetails disbursementDetails;
  PayPalDetails payPalDetails;
  ShippingAddress shippingAddress;
  SubscriptionDetails subscriptionDetails;

  Transaction.fromParams(
      {this.additionalProcessorResponse,
      this.amexExpressCheckoutDetails,
      this.applePayDetails,
      this.authorizedTransactionId,
      this.avsErrorResponseCode,
      this.channel,
      this.coinbaseDetails,
      this.customFields,
      this.discountAmount,
      this.escrowStatus,
      this.facilitatedDetails,
      this.facilitatorDetails,
      this.gatewayRejectionReason,
      this.idealPaymentDetails,
      this.localPaymentDetails,
      this.masterpassCardDetails,
      this.orderId,
      this.payPalHereDetails,
      this.paymentInstrumentType,
      this.planId,
      this.processorResponseType,
      this.purchaseOrderNumber,
      this.refundedTransactionId,
      this.riskData,
      this.samsungPayCardDetails,
      this.serviceFeeAmount,
      this.shippingAmount,
      this.shipsFromPostalCode,
      this.status,
      this.subscriptionId,
      this.taxAmount,
      this.threeDSecureInfo,
      this.type,
      this.usBankAccountDetails,
      this.venmoAccountDetails,
      this.visaCheckoutCardDetails,
      this.voiceReferralNumber,
      this.amount,
      this.recurring,
      this.taxExempt,
      this.authorizationExpiresAt,
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
      this.networkTransactionId,
      this.processorAuthorizationCode,
      this.processorResponseCode,
      this.processorResponseText,
      this.processorSettlementResponseCode,
      this.processorSettlementResponseText,
      this.settlementBatchId,
      this.updatedAt,
      this.addOns,
      this.authorizationAdjustments,
      this.discounts,
      this.disputes,
      this.partialSettlementTransactionIds,
      this.refundIds,
      this.statusHistory,
      this.androidPayDetails,
      this.billingAddress,
      this.creditCard,
      this.customerDetails,
      this.descriptor,
      this.disbursementDetails,
      this.payPalDetails,
      this.shippingAddress,
      this.subscriptionDetails});

  Transaction.fromJson(jsonRes) {
    additionalProcessorResponse = jsonRes['additionalProcessorResponse'];
    amexExpressCheckoutDetails = jsonRes['amexExpressCheckoutDetails'];
    applePayDetails = jsonRes['applePayDetails'];
    authorizedTransactionId = jsonRes['authorizedTransactionId'];
    avsErrorResponseCode = jsonRes['avsErrorResponseCode'];
    channel = jsonRes['channel'];
    coinbaseDetails = jsonRes['coinbaseDetails'];
    customFields = jsonRes['customFields'];
    discountAmount = jsonRes['discountAmount'];
    escrowStatus = jsonRes['escrowStatus'];
    facilitatedDetails = jsonRes['facilitatedDetails'];
    facilitatorDetails = jsonRes['facilitatorDetails'];
    gatewayRejectionReason = jsonRes['gatewayRejectionReason'];
    idealPaymentDetails = jsonRes['idealPaymentDetails'];
    localPaymentDetails = jsonRes['localPaymentDetails'];
    masterpassCardDetails = jsonRes['masterpassCardDetails'];
    orderId = jsonRes['orderId'];
    payPalHereDetails = jsonRes['payPalHereDetails'];
    paymentInstrumentType = jsonRes['paymentInstrumentType'];
    planId = jsonRes['planId'];
    processorResponseType = jsonRes['processorResponseType'];
    purchaseOrderNumber = jsonRes['purchaseOrderNumber'];
    refundedTransactionId = jsonRes['refundedTransactionId'];
    riskData = jsonRes['riskData'];
    samsungPayCardDetails = jsonRes['samsungPayCardDetails'];
    serviceFeeAmount = jsonRes['serviceFeeAmount'];
    shippingAmount = jsonRes['shippingAmount'];
    shipsFromPostalCode = jsonRes['shipsFromPostalCode'];
    status = jsonRes['status'];
    subscriptionId = jsonRes['subscriptionId'];
    taxAmount = jsonRes['taxAmount'];
    threeDSecureInfo = jsonRes['threeDSecureInfo'];
    type = jsonRes['type'];
    usBankAccountDetails = jsonRes['usBankAccountDetails'];
    venmoAccountDetails = jsonRes['venmoAccountDetails'];
    visaCheckoutCardDetails = jsonRes['visaCheckoutCardDetails'];
    voiceReferralNumber = jsonRes['voiceReferralNumber'];
    amount = jsonRes['amount'];
    recurring = jsonRes['recurring'];
    taxExempt = jsonRes['taxExempt'];
    authorizationExpiresAt = jsonRes['authorizationExpiresAt'];
    avsPostalCodeResponseCode = jsonRes['avsPostalCodeResponseCode'];
    avsStreetAddressResponseCode = jsonRes['avsStreetAddressResponseCode'];
    createdAt = jsonRes['createdAt'];
    currencyIsoCode = jsonRes['currencyIsoCode'];
    cvvResponseCode = jsonRes['cvvResponseCode'];
    graphQLId = jsonRes['graphQLId'];
    id = jsonRes['id'];
    merchantAccountId = jsonRes['merchantAccountId'];
    networkResponseCode = jsonRes['networkResponseCode'];
    networkResponseText = jsonRes['networkResponseText'];
    networkTransactionId = jsonRes['networkTransactionId'];
    processorAuthorizationCode = jsonRes['processorAuthorizationCode'];
    processorResponseCode = jsonRes['processorResponseCode'];
    processorResponseText = jsonRes['processorResponseText'];
    processorSettlementResponseCode =
        jsonRes['processorSettlementResponseCode'];
    processorSettlementResponseText =
        jsonRes['processorSettlementResponseText'];
    settlementBatchId = jsonRes['settlementBatchId'];
    updatedAt = jsonRes['updatedAt'];
    addOns = jsonRes['addOns'] == null ? null : [];

    for (var addOnsItem in addOns == null ? [] : jsonRes['addOns']) {
      addOns.add(addOnsItem);
    }

    authorizationAdjustments =
        jsonRes['authorizationAdjustments'] == null ? null : [];

    for (var authorizationAdjustmentsItem in authorizationAdjustments == null
        ? []
        : jsonRes['authorizationAdjustments']) {
      authorizationAdjustments.add(authorizationAdjustmentsItem);
    }

    discounts = jsonRes['discounts'] == null ? null : [];

    for (var discountsItem in discounts == null ? [] : jsonRes['discounts']) {
      discounts.add(discountsItem);
    }

    disputes = jsonRes['disputes'] == null ? null : [];

    for (var disputesItem in disputes == null ? [] : jsonRes['disputes']) {
      disputes.add(disputesItem);
    }

    partialSettlementTransactionIds =
        jsonRes['partialSettlementTransactionIds'] == null ? null : [];

    for (var partialSettlementTransactionIdsItem
        in partialSettlementTransactionIds == null
            ? []
            : jsonRes['partialSettlementTransactionIds']) {
      partialSettlementTransactionIds.add(partialSettlementTransactionIdsItem);
    }

    refundIds = jsonRes['refundIds'] == null ? null : [];

    for (var refundIdsItem in refundIds == null ? [] : jsonRes['refundIds']) {
      refundIds.add(refundIdsItem);
    }

    statusHistory = jsonRes['statusHistory'] == null ? null : [];

    for (var statusHistoryItem
        in statusHistory == null ? [] : jsonRes['statusHistory']) {
      statusHistory.add(statusHistoryItem == null
          ? null
          : new StatusHistory.fromJson(statusHistoryItem));
    }

    androidPayDetails = jsonRes['androidPayDetails'] == null
        ? null
        : new AndroidPayDetails.fromJson(jsonRes['androidPayDetails']);
    billingAddress = jsonRes['billingAddress'] == null
        ? null
        : new BillingAddress.fromJson(jsonRes['billingAddress']);
    creditCard = jsonRes['creditCard'] == null
        ? null
        : new CreditCard.fromJson(jsonRes['creditCard']);
    customerDetails = jsonRes['customerDetails'] == null
        ? null
        : new CustomerDetails.fromJson(jsonRes['customerDetails']);
    descriptor = jsonRes['descriptor'] == null
        ? null
        : new Descriptor.fromJson(jsonRes['descriptor']);
    disbursementDetails = jsonRes['disbursementDetails'] == null
        ? null
        : new DisbursementDetails.fromJson(jsonRes['disbursementDetails']);
    payPalDetails = jsonRes['payPalDetails'] == null
        ? null
        : new PayPalDetails.fromJson(jsonRes['payPalDetails']);
    shippingAddress = jsonRes['shippingAddress'] == null
        ? null
        : new ShippingAddress.fromJson(jsonRes['shippingAddress']);
    subscriptionDetails = jsonRes['subscriptionDetails'] == null
        ? null
        : new SubscriptionDetails.fromJson(jsonRes['subscriptionDetails']);
  }

  @override
  String toString() {
    return '{"additionalProcessorResponse": $additionalProcessorResponse,"amexExpressCheckoutDetails": $amexExpressCheckoutDetails,"applePayDetails": $applePayDetails,"authorizedTransactionId": $authorizedTransactionId,"avsErrorResponseCode": $avsErrorResponseCode,"channel": $channel,"coinbaseDetails": $coinbaseDetails,"customFields": $customFields,"discountAmount": $discountAmount,"escrowStatus": $escrowStatus,"facilitatedDetails": $facilitatedDetails,"facilitatorDetails": $facilitatorDetails,"gatewayRejectionReason": $gatewayRejectionReason,"idealPaymentDetails": ${id != null ? '${json.encode(id)}' : 'null'}ealPaymentDetails,"localPaymentDetails": $localPaymentDetails,"masterpassCardDetails": $masterpassCardDetails,"orderId": $orderId,"payPalHereDetails": $payPalHereDetails,"paymentInstrumentType": $paymentInstrumentType,"planId": $planId,"processorResponseType": $processorResponseType,"purchaseOrderNumber": $purchaseOrderNumber,"refundedTransactionId": $refundedTransactionId,"riskData": $riskData,"samsungPayCardDetails": $samsungPayCardDetails,"serviceFeeAmount": $serviceFeeAmount,"shippingAmount": $shippingAmount,"shipsFromPostalCode": $shipsFromPostalCode,"status": $status,"subscriptionId": $subscriptionId,"taxAmount": $taxAmount,"threeDSecureInfo": $threeDSecureInfo,"type": $type,"usBankAccountDetails": $usBankAccountDetails,"venmoAccountDetails": $venmoAccountDetails,"visaCheckoutCardDetails": $visaCheckoutCardDetails,"voiceReferralNumber": $voiceReferralNumber,"amount": $amount,"recurring": $recurring,"taxExempt": $taxExempt,"authorizationExpiresAt": ${authorizationExpiresAt != null ? '${json.encode(authorizationExpiresAt)}' : 'null'},"avsPostalCodeResponseCode": ${avsPostalCodeResponseCode != null ? '${json.encode(avsPostalCodeResponseCode)}' : 'null'},"avsStreetAddressResponseCode": ${avsStreetAddressResponseCode != null ? '${json.encode(avsStreetAddressResponseCode)}' : 'null'},"createdAt": ${createdAt != null ? '${json.encode(createdAt)}' : 'null'},"currencyIsoCode": ${currencyIsoCode != null ? '${json.encode(currencyIsoCode)}' : 'null'},"cvvResponseCode": ${cvvResponseCode != null ? '${json.encode(cvvResponseCode)}' : 'null'},"graphQLId": ${graphQLId != null ? '${json.encode(graphQLId)}' : 'null'},"id": ${id != null ? '${json.encode(id)}' : 'null'},"merchantAccountId": ${merchantAccountId != null ? '${json.encode(merchantAccountId)}' : 'null'},"networkResponseCode": ${networkResponseCode != null ? '${json.encode(networkResponseCode)}' : 'null'},"networkResponseText": ${networkResponseText != null ? '${json.encode(networkResponseText)}' : 'null'},"networkTransactionId": ${networkTransactionId != null ? '${json.encode(networkTransactionId)}' : 'null'},"processorAuthorizationCode": ${processorAuthorizationCode != null ? '${json.encode(processorAuthorizationCode)}' : 'null'},"processorResponseCode": ${processorResponseCode != null ? '${json.encode(processorResponseCode)}' : 'null'},"processorResponseText": ${processorResponseText != null ? '${json.encode(processorResponseText)}' : 'null'},"processorSettlementResponseCode": ${processorSettlementResponseCode != null ? '${json.encode(processorSettlementResponseCode)}' : 'null'},"processorSettlementResponseText": ${processorSettlementResponseText != null ? '${json.encode(processorSettlementResponseText)}' : 'null'},"settlementBatchId": ${settlementBatchId != null ? '${json.encode(settlementBatchId)}' : 'null'},"updatedAt": ${updatedAt != null ? '${json.encode(updatedAt)}' : 'null'},"addOns": $addOns,"authorizationAdjustments": $authorizationAdjustments,"discounts": $discounts,"disputes": $disputes,"partialSettlementTransactionIds": $partialSettlementTransactionIds,"refundIds": $refundIds,"statusHistory": $statusHistory,"androidPayDetails": $androidPayDetails,"billingAddress": $billingAddress,"creditCard": $creditCard,"customerDetails": $customerDetails,"descriptor": $descriptor,"disbursementDetails": $disbursementDetails,"payPalDetails": $payPalDetails,"shippingAddress": $shippingAddress,"subscriptionDetails": $subscriptionDetails}';
  }
}

class SubscriptionDetails {
  Object billingPeriodEndDate;
  Object billingPeriodStartDate;

  SubscriptionDetails.fromParams(
      {this.billingPeriodEndDate, this.billingPeriodStartDate});

  SubscriptionDetails.fromJson(jsonRes) {
    billingPeriodEndDate = jsonRes['billingPeriodEndDate'];
    billingPeriodStartDate = jsonRes['billingPeriodStartDate'];
  }

  @override
  String toString() {
    return '{"billingPeriodEndDate": $billingPeriodEndDate,"billingPeriodStartDate": $billingPeriodStartDate}';
  }
}

class ShippingAddress {
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

  ShippingAddress.fromParams(
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

  ShippingAddress.fromJson(jsonRes) {
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

class PayPalDetails {
  Object customField;
  Object description;
  Object payeeEmail;
  Object payeeId;
  Object refundFromTransactionFeeAmount;
  Object refundFromTransactionFeeCurrencyIsoCode;
  Object refundId;
  String authorizationId;
  String captureId;
  String debugId;
  String imageUrl;
  String payerEmail;
  String payerFirstName;
  String payerId;
  String payerLastName;
  String payerStatus;
  String paymentId;
  String sellerProtectionStatus;
  String token;
  String transactionFeeAmount;
  String transactionFeeCurrencyIsoCode;

  PayPalDetails.fromParams(
      {this.customField,
      this.description,
      this.payeeEmail,
      this.payeeId,
      this.refundFromTransactionFeeAmount,
      this.refundFromTransactionFeeCurrencyIsoCode,
      this.refundId,
      this.authorizationId,
      this.captureId,
      this.debugId,
      this.imageUrl,
      this.payerEmail,
      this.payerFirstName,
      this.payerId,
      this.payerLastName,
      this.payerStatus,
      this.paymentId,
      this.sellerProtectionStatus,
      this.token,
      this.transactionFeeAmount,
      this.transactionFeeCurrencyIsoCode});

  PayPalDetails.fromJson(jsonRes) {
    customField = jsonRes['customField'];
    description = jsonRes['description'];
    payeeEmail = jsonRes['payeeEmail'];
    payeeId = jsonRes['payeeId'];
    refundFromTransactionFeeAmount = jsonRes['refundFromTransactionFeeAmount'];
    refundFromTransactionFeeCurrencyIsoCode =
        jsonRes['refundFromTransactionFeeCurrencyIsoCode'];
    refundId = jsonRes['refundId'];
    authorizationId = jsonRes['authorizationId'];
    captureId = jsonRes['captureId'];
    debugId = jsonRes['debugId'];
    imageUrl = jsonRes['imageUrl'];
    payerEmail = jsonRes['payerEmail'];
    payerFirstName = jsonRes['payerFirstName'];
    payerId = jsonRes['payerId'];
    payerLastName = jsonRes['payerLastName'];
    payerStatus = jsonRes['payerStatus'];
    paymentId = jsonRes['paymentId'];
    sellerProtectionStatus = jsonRes['sellerProtectionStatus'];
    token = jsonRes['token'];
    transactionFeeAmount = jsonRes['transactionFeeAmount'];
    transactionFeeCurrencyIsoCode = jsonRes['transactionFeeCurrencyIsoCode'];
  }

  @override
  String toString() {
    return '{"customField": $customField,"description": $description,"payeeEmail": $payeeEmail,"payeeId": $payeeId,"refundFromTransactionFeeAmount": $refundFromTransactionFeeAmount,"refundFromTransactionFeeCurrencyIsoCode": $refundFromTransactionFeeCurrencyIsoCode,"refundId": $refundId,"authorizationId": ${authorizationId != null ? '${json.encode(authorizationId)}' : 'null'},"captureId": ${captureId != null ? '${json.encode(captureId)}' : 'null'},"debugId": ${debugId != null ? '${json.encode(debugId)}' : 'null'},"imageUrl": ${imageUrl != null ? '${json.encode(imageUrl)}' : 'null'},"payerEmail": ${payerEmail != null ? '${json.encode(payerEmail)}' : 'null'},"payerFirstName": ${payerFirstName != null ? '${json.encode(payerFirstName)}' : 'null'},"payerId": ${payerId != null ? '${json.encode(payerId)}' : 'null'},"payerLastName": ${payerLastName != null ? '${json.encode(payerLastName)}' : 'null'},"payerStatus": ${payerStatus != null ? '${json.encode(payerStatus)}' : 'null'},"paymentId": ${paymentId != null ? '${json.encode(paymentId)}' : 'null'},"sellerProtectionStatus": ${sellerProtectionStatus != null ? '${json.encode(sellerProtectionStatus)}' : 'null'},"token": ${token != null ? '${json.encode(token)}' : 'null'},"transactionFeeAmount": ${transactionFeeAmount != null ? '${json.encode(transactionFeeAmount)}' : 'null'},"transactionFeeCurrencyIsoCode": ${transactionFeeCurrencyIsoCode != null ? '${json.encode(transactionFeeCurrencyIsoCode)}' : 'null'}}';
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
    disbursementDate = jsonRes['disbursementDate'];
    fundsHeld = jsonRes['fundsHeld'];
    settlementAmount = jsonRes['settlementAmount'];
    settlementCurrencyExchangeRate = jsonRes['settlementCurrencyExchangeRate'];
    settlementCurrencyIsoCode = jsonRes['settlementCurrencyIsoCode'];
    success = jsonRes['success'];
  }

  @override
  String toString() {
    return '{"disbursementDate": $disbursementDate,"fundsHeld": $fundsHeld,"settlementAmount": $settlementAmount,"settlementCurrencyExchangeRate": $settlementCurrencyExchangeRate,"settlementCurrencyIsoCode": $settlementCurrencyIsoCode,"success": $success}';
  }
}

class Descriptor {
  Object name;
  Object phone;
  Object url;

  Descriptor.fromParams({this.name, this.phone, this.url});

  Descriptor.fromJson(jsonRes) {
    name = jsonRes['name'];
    phone = jsonRes['phone'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"name": $name,"phone": $phone,"url": $url}';
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
    company = jsonRes['company'];
    email = jsonRes['email'];
    fax = jsonRes['fax'];
    firstName = jsonRes['firstName'];
    lastName = jsonRes['lastName'];
    phone = jsonRes['phone'];
    website = jsonRes['website'];
    id = jsonRes['id'];
  }

  @override
  String toString() {
    return '{"company": $company,"email": $email,"fax": $fax,"firstName": $firstName,"lastName": $lastName,"phone": $phone,"website": $website,"id": ${id != null ? '${json.encode(id)}' : 'null'}}';
  }
}

class CreditCard {
  Object accountType;
  Object cardType;
  Object cardholderName;
  Object commercial;
  Object createdAt;
  Object customerId;
  Object customerLocation;
  Object debit;
  Object durbinRegulated;
  Object healthcare;
  Object isDefault;
  Object isExpired;
  Object payroll;
  Object prepaid;
  Object updatedAt;
  Object verification;
  bool isVenmoSdk;
  String bin;
  String countryOfIssuance;
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
  List<dynamic> subscriptions;
  BillingAddress billingAddress;

  CreditCard.fromParams(
      {this.accountType,
      this.cardType,
      this.cardholderName,
      this.commercial,
      this.createdAt,
      this.customerId,
      this.customerLocation,
      this.debit,
      this.durbinRegulated,
      this.healthcare,
      this.isDefault,
      this.isExpired,
      this.payroll,
      this.prepaid,
      this.updatedAt,
      this.verification,
      this.isVenmoSdk,
      this.bin,
      this.countryOfIssuance,
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
      this.subscriptions,
      this.billingAddress});

  CreditCard.fromJson(jsonRes) {
    accountType = jsonRes['accountType'];
    cardType = jsonRes['cardType'];
    cardholderName = jsonRes['cardholderName'];
    commercial = jsonRes['commercial'];
    createdAt = jsonRes['createdAt'];
    customerId = jsonRes['customerId'];
    customerLocation = jsonRes['customerLocation'];
    debit = jsonRes['debit'];
    durbinRegulated = jsonRes['durbinRegulated'];
    healthcare = jsonRes['healthcare'];
    isDefault = jsonRes['isDefault'];
    isExpired = jsonRes['isExpired'];
    payroll = jsonRes['payroll'];
    prepaid = jsonRes['prepaid'];
    updatedAt = jsonRes['updatedAt'];
    verification = jsonRes['verification'];
    isVenmoSdk = jsonRes['isVenmoSdk'];
    bin = jsonRes['bin'];
    countryOfIssuance = jsonRes['countryOfIssuance'];
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
    return '{"accountType": $accountType,"cardType": $cardType,"cardholderName": $cardholderName,"commercial": $commercial,"createdAt": $createdAt,"customerId": $customerId,"customerLocation": $customerLocation,"debit": $debit,"durbinRegulated": $durbinRegulated,"healthcare": $healthcare,"isDefault": $isDefault,"isExpired": $isExpired,"payroll": $payroll,"prepaid": $prepaid,"updatedAt": $updatedAt,"verification": $verification,"isVenmoSdk": $isVenmoSdk,"bin": ${bin != null ? '${json.encode(bin)}' : 'null'},"countryOfIssuance": ${countryOfIssuance != null ? '${json.encode(countryOfIssuance)}' : 'null'},"expirationDate": ${expirationDate != null ? '${json.encode(expirationDate)}' : 'null'},"expirationMonth": ${expirationMonth != null ? '${json.encode(expirationMonth)}' : 'null'},"expirationYear": ${expirationYear != null ? '${json.encode(expirationYear)}' : 'null'},"imageUrl": ${imageUrl != null ? '${json.encode(imageUrl)}' : 'null'},"issuingBank": ${issuingBank != null ? '${json.encode(issuingBank)}' : 'null'},"lastFour": ${lastFour != null ? '${json.encode(lastFour)}' : 'null'},"maskedNumber": ${maskedNumber != null ? '${json.encode(maskedNumber)}' : 'null'},"productId": ${productId != null ? '${json.encode(productId)}' : 'null'},"token": ${token != null ? '${json.encode(token)}' : 'null'},"uniqueNumberIdentifier": ${uniqueNumberIdentifier != null ? '${json.encode(uniqueNumberIdentifier)}' : 'null'},"subscriptions": $subscriptions,"billingAddress": $billingAddress}';
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

class AndroidPayDetails {
  Object countryOfIssuance;
  Object globalId;
  Object issuingBank;
  Object token;
  bool isNetworkTokenized;
  String bin;
  String cardType;
  String commercial;
  String debit;
  String durbinRegulated;
  String expirationMonth;
  String expirationYear;
  String googleTransactionId;
  String healthcare;
  String imageUrl;
  String last4;
  String payroll;
  String prepaid;
  String productId;
  String sourceCardLast4;
  String sourceCardType;
  String sourceDescription;
  String virtualCardLast4;
  String virtualCardType;

  AndroidPayDetails.fromParams(
      {this.countryOfIssuance,
      this.globalId,
      this.issuingBank,
      this.token,
      this.isNetworkTokenized,
      this.bin,
      this.cardType,
      this.commercial,
      this.debit,
      this.durbinRegulated,
      this.expirationMonth,
      this.expirationYear,
      this.googleTransactionId,
      this.healthcare,
      this.imageUrl,
      this.last4,
      this.payroll,
      this.prepaid,
      this.productId,
      this.sourceCardLast4,
      this.sourceCardType,
      this.sourceDescription,
      this.virtualCardLast4,
      this.virtualCardType});

  AndroidPayDetails.fromJson(jsonRes) {
    countryOfIssuance = jsonRes['countryOfIssuance'];
    globalId = jsonRes['globalId'];
    issuingBank = jsonRes['issuingBank'];
    token = jsonRes['token'];
    isNetworkTokenized = jsonRes['isNetworkTokenized'];
    bin = jsonRes['bin'];
    cardType = jsonRes['cardType'];
    commercial = jsonRes['commercial'];
    debit = jsonRes['debit'];
    durbinRegulated = jsonRes['durbinRegulated'];
    expirationMonth = jsonRes['expirationMonth'];
    expirationYear = jsonRes['expirationYear'];
    googleTransactionId = jsonRes['googleTransactionId'];
    healthcare = jsonRes['healthcare'];
    imageUrl = jsonRes['imageUrl'];
    last4 = jsonRes['last4'];
    payroll = jsonRes['payroll'];
    prepaid = jsonRes['prepaid'];
    productId = jsonRes['productId'];
    sourceCardLast4 = jsonRes['sourceCardLast4'];
    sourceCardType = jsonRes['sourceCardType'];
    sourceDescription = jsonRes['sourceDescription'];
    virtualCardLast4 = jsonRes['virtualCardLast4'];
    virtualCardType = jsonRes['virtualCardType'];
  }

  @override
  String toString() {
    return '{"countryOfIssuance": $countryOfIssuance,"globalId": $globalId,"issuingBank": $issuingBank,"token": $token,"isNetworkTokenized": $isNetworkTokenized,"bin": ${bin != null ? '${json.encode(bin)}' : 'null'},"cardType": ${cardType != null ? '${json.encode(cardType)}' : 'null'},"commercial": ${commercial != null ? '${json.encode(commercial)}' : 'null'},"debit": ${debit != null ? '${json.encode(debit)}' : 'null'},"durbinRegulated": ${durbinRegulated != null ? '${json.encode(durbinRegulated)}' : 'null'},"expirationMonth": ${expirationMonth != null ? '${json.encode(expirationMonth)}' : 'null'},"expirationYear": ${expirationYear != null ? '${json.encode(expirationYear)}' : 'null'},"googleTransactionId": ${googleTransactionId != null ? '${json.encode(googleTransactionId)}' : 'null'},"healthcare": ${healthcare != null ? '${json.encode(healthcare)}' : 'null'},"imageUrl": ${imageUrl != null ? '${json.encode(imageUrl)}' : 'null'},"last4": ${last4 != null ? '${json.encode(last4)}' : 'null'},"payroll": ${payroll != null ? '${json.encode(payroll)}' : 'null'},"prepaid": ${prepaid != null ? '${json.encode(prepaid)}' : 'null'},"productId": ${productId != null ? '${json.encode(productId)}' : 'null'},"sourceCardLast4": ${sourceCardLast4 != null ? '${json.encode(sourceCardLast4)}' : 'null'},"sourceCardType": ${sourceCardType != null ? '${json.encode(sourceCardType)}' : 'null'},"sourceDescription": ${sourceDescription != null ? '${json.encode(sourceDescription)}' : 'null'},"virtualCardLast4": ${virtualCardLast4 != null ? '${json.encode(virtualCardLast4)}' : 'null'},"virtualCardType": ${virtualCardType != null ? '${json.encode(virtualCardType)}' : 'null'}}';
  }
}

class StatusHistory {
  Object source;
  Object status;
  double amount;
  String timestamp;
  String user;

  StatusHistory.fromParams(
      {this.source, this.status, this.amount, this.timestamp, this.user});

  StatusHistory.fromJson(jsonRes) {
    source = jsonRes['source'];
    status = jsonRes['status'];
    amount = jsonRes['amount'];
    timestamp = jsonRes['timestamp'];
    user = jsonRes['user'];
  }

  @override
  String toString() {
    return '{"source": $source,"status": $status,"amount": $amount,"timestamp": ${timestamp != null ? '${json.encode(timestamp)}' : 'null'},"user": ${user != null ? '${json.encode(user)}' : 'null'}}';
  }
}
