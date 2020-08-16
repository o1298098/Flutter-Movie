import 'dart:convert' show json;

import 'braintree_billing_address.dart';
import 'braintree_creditcard.dart';
import 'braintree_customer_details.dart';
import 'braintree_descriptor.dart';
import 'braintree_item_type.dart';
import 'braintree_status_history.dart';
import 'branintree_disbursement_details.dart';

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
  Object facilitatedDetails;
  Object facilitatorDetails;
  Object idealPaymentDetails;
  Object localPaymentDetails;
  Object masterpassCardDetails;
  Object orderId;
  Object payPalHereDetails;
  Object purchaseOrderNumber;
  Object refundedTransactionId;
  Object riskData;
  Object samsungPayCardDetails;
  Object serviceFeeAmount;
  Object shippingAmount;
  Object shipsFromPostalCode;
  Object taxAmount;
  Object threeDSecureInfo;
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
  String planId;
  String processorAuthorizationCode;
  String processorResponseCode;
  String processorResponseText;
  String processorSettlementResponseCode;
  String processorSettlementResponseText;
  String settlementBatchId;
  String subscriptionId;
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
  BraintreeDescriptor descriptor;
  DisbursementDetails disbursementDetails;
  ItemType escrowStatus;
  ItemType gatewayRejectionReason;
  PayPalDetails payPalDetails;
  ItemType paymentInstrumentType;
  ItemType processorResponseType;
  BillingAddress shippingAddress;
  ItemType status;
  ItemType subscriptionDetails;
  ItemType type;

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
      this.facilitatedDetails,
      this.facilitatorDetails,
      this.idealPaymentDetails,
      this.localPaymentDetails,
      this.masterpassCardDetails,
      this.orderId,
      this.payPalHereDetails,
      this.purchaseOrderNumber,
      this.refundedTransactionId,
      this.riskData,
      this.samsungPayCardDetails,
      this.serviceFeeAmount,
      this.shippingAmount,
      this.shipsFromPostalCode,
      this.taxAmount,
      this.threeDSecureInfo,
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
      this.planId,
      this.processorAuthorizationCode,
      this.processorResponseCode,
      this.processorResponseText,
      this.processorSettlementResponseCode,
      this.processorSettlementResponseText,
      this.settlementBatchId,
      this.subscriptionId,
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
      this.escrowStatus,
      this.gatewayRejectionReason,
      this.payPalDetails,
      this.paymentInstrumentType,
      this.processorResponseType,
      this.shippingAddress,
      this.status,
      this.subscriptionDetails,
      this.type});

  Transaction.fromJson(jsonRes) {
    additionalProcessorResponse = jsonRes['AdditionalProcessorResponse'];
    amexExpressCheckoutDetails = jsonRes['AmexExpressCheckoutDetails'];
    applePayDetails = jsonRes['ApplePayDetails'];
    authorizedTransactionId = jsonRes['AuthorizedTransactionId'];
    avsErrorResponseCode = jsonRes['AvsErrorResponseCode'];
    channel = jsonRes['Channel'];
    coinbaseDetails = jsonRes['CoinbaseDetails'];
    customFields = jsonRes['CustomFields'];
    discountAmount = jsonRes['DiscountAmount'];
    facilitatedDetails = jsonRes['FacilitatedDetails'];
    facilitatorDetails = jsonRes['FacilitatorDetails'];
    idealPaymentDetails = jsonRes['IdealPaymentDetails'];
    localPaymentDetails = jsonRes['LocalPaymentDetails'];
    masterpassCardDetails = jsonRes['MasterpassCardDetails'];
    orderId = jsonRes['OrderId'];
    payPalHereDetails = jsonRes['PayPalHereDetails'];
    purchaseOrderNumber = jsonRes['PurchaseOrderNumber'];
    refundedTransactionId = jsonRes['RefundedTransactionId'];
    riskData = jsonRes['RiskData'];
    samsungPayCardDetails = jsonRes['SamsungPayCardDetails'];
    serviceFeeAmount = jsonRes['ServiceFeeAmount'];
    shippingAmount = jsonRes['ShippingAmount'];
    shipsFromPostalCode = jsonRes['ShipsFromPostalCode'];
    taxAmount = jsonRes['TaxAmount'];
    threeDSecureInfo = jsonRes['ThreeDSecureInfo'];
    usBankAccountDetails = jsonRes['UsBankAccountDetails'];
    venmoAccountDetails = jsonRes['VenmoAccountDetails'];
    visaCheckoutCardDetails = jsonRes['VisaCheckoutCardDetails'];
    voiceReferralNumber = jsonRes['VoiceReferralNumber'];
    amount = jsonRes['Amount'];
    recurring = jsonRes['Recurring'];
    taxExempt = jsonRes['TaxExempt'];
    authorizationExpiresAt = jsonRes['AuthorizationExpiresAt'];
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
    networkTransactionId = jsonRes['NetworkTransactionId'];
    planId = jsonRes['PlanId'];
    processorAuthorizationCode = jsonRes['ProcessorAuthorizationCode'];
    processorResponseCode = jsonRes['ProcessorResponseCode'];
    processorResponseText = jsonRes['ProcessorResponseText'];
    processorSettlementResponseCode =
        jsonRes['ProcessorSettlementResponseCode'];
    processorSettlementResponseText =
        jsonRes['ProcessorSettlementResponseText'];
    settlementBatchId = jsonRes['SettlementBatchId'];
    subscriptionId = jsonRes['SubscriptionId'];
    updatedAt = jsonRes['UpdatedAt'];
    addOns = jsonRes['AddOns'] == null ? null : [];

    for (var addOnsItem in addOns == null ? [] : jsonRes['AddOns']) {
      addOns.add(addOnsItem);
    }

    authorizationAdjustments =
        jsonRes['AuthorizationAdjustments'] == null ? null : [];

    for (var authorizationAdjustmentsItem in authorizationAdjustments == null
        ? []
        : jsonRes['AuthorizationAdjustments']) {
      authorizationAdjustments.add(authorizationAdjustmentsItem);
    }

    discounts = jsonRes['Discounts'] == null ? null : [];

    for (var discountsItem in discounts == null ? [] : jsonRes['Discounts']) {
      discounts.add(discountsItem);
    }

    disputes = jsonRes['Disputes'] == null ? null : [];

    for (var disputesItem in disputes == null ? [] : jsonRes['Disputes']) {
      disputes.add(disputesItem);
    }

    partialSettlementTransactionIds =
        jsonRes['PartialSettlementTransactionIds'] == null ? null : [];

    for (var partialSettlementTransactionIdsItem
        in partialSettlementTransactionIds == null
            ? []
            : jsonRes['PartialSettlementTransactionIds']) {
      partialSettlementTransactionIds.add(partialSettlementTransactionIdsItem);
    }

    refundIds = jsonRes['RefundIds'] == null ? null : [];

    for (var refundIdsItem in refundIds == null ? [] : jsonRes['RefundIds']) {
      refundIds.add(refundIdsItem);
    }

    statusHistory = jsonRes['StatusHistory'] == null ? null : [];

    for (var statusHistoryItem
        in statusHistory == null ? [] : jsonRes['StatusHistory']) {
      statusHistory.add(statusHistoryItem == null
          ? null
          : new StatusHistory.fromJson(statusHistoryItem));
    }

    androidPayDetails = jsonRes['AndroidPayDetails'] == null
        ? null
        : new AndroidPayDetails.fromJson(jsonRes['AndroidPayDetails']);
    billingAddress = jsonRes['BillingAddress'] == null
        ? null
        : new BillingAddress.fromJson(jsonRes['BillingAddress']);
    creditCard = jsonRes['CreditCard'] == null
        ? null
        : new CreditCard.fromJson(jsonRes['CreditCard']);
    customerDetails = jsonRes['CustomerDetails'] == null
        ? null
        : new CustomerDetails.fromJson(jsonRes['CustomerDetails']);
    descriptor = jsonRes['Descriptor'] == null
        ? null
        : new BraintreeDescriptor.fromJson(jsonRes['Descriptor']);
    disbursementDetails = jsonRes['DisbursementDetails'] == null
        ? null
        : new DisbursementDetails.fromJson(jsonRes['DisbursementDetails']);
    escrowStatus = jsonRes['EscrowStatus'] == null
        ? null
        : new ItemType.fromJson(jsonRes['EscrowStatus']);
    gatewayRejectionReason = jsonRes['GatewayRejectionReason'] == null
        ? null
        : new ItemType.fromJson(jsonRes['GatewayRejectionReason']);
    payPalDetails = jsonRes['PayPalDetails'] == null
        ? null
        : new PayPalDetails.fromJson(jsonRes['PayPalDetails']);
    paymentInstrumentType = jsonRes['PaymentInstrumentType'] == null
        ? null
        : new ItemType.fromJson(jsonRes['PaymentInstrumentType']);
    processorResponseType = jsonRes['ProcessorResponseType'] == null
        ? null
        : new ItemType.fromJson(jsonRes['ProcessorResponseType']);
    shippingAddress = jsonRes['ShippingAddress'] == null
        ? null
        : new BillingAddress.fromJson(jsonRes['ShippingAddress']);
    status = jsonRes['Status'] == null
        ? null
        : new ItemType.fromJson(jsonRes['Status']);
    subscriptionDetails = jsonRes['SubscriptionDetails'] == null
        ? null
        : new ItemType.fromJson(jsonRes['SubscriptionDetails']);
    type =
        jsonRes['Type'] == null ? null : new ItemType.fromJson(jsonRes['Type']);
  }

  @override
  String toString() {
    return '{"AdditionalProcessorResponse": $additionalProcessorResponse,"AmexExpressCheckoutDetails": $amexExpressCheckoutDetails,"ApplePayDetails": $applePayDetails,"AuthorizedTransactionId": $authorizedTransactionId,"AvsErrorResponseCode": $avsErrorResponseCode,"Channel": $channel,"CoinbaseDetails": $coinbaseDetails,"CustomFields": $customFields,"DiscountAmount": $discountAmount,"FacilitatedDetails": $facilitatedDetails,"FacilitatorDetails": $facilitatorDetails,"IdealPaymentDetails": ${id != null ? '${json.encode(id)}' : 'null'}ealPaymentDetails,"LocalPaymentDetails": $localPaymentDetails,"MasterpassCardDetails": $masterpassCardDetails,"OrderId": $orderId,"PayPalHereDetails": $payPalHereDetails,"PurchaseOrderNumber": $purchaseOrderNumber,"RefundedTransactionId": $refundedTransactionId,"RiskData": $riskData,"SamsungPayCardDetails": $samsungPayCardDetails,"ServiceFeeAmount": $serviceFeeAmount,"ShippingAmount": $shippingAmount,"ShipsFromPostalCode": $shipsFromPostalCode,"TaxAmount": $taxAmount,"ThreeDSecureInfo": $threeDSecureInfo,"UsBankAccountDetails": $usBankAccountDetails,"VenmoAccountDetails": $venmoAccountDetails,"VisaCheckoutCardDetails": $visaCheckoutCardDetails,"VoiceReferralNumber": $voiceReferralNumber,"Amount": $amount,"Recurring": $recurring,"TaxExempt": $taxExempt,"AuthorizationExpiresAt": ${authorizationExpiresAt != null ? '${json.encode(authorizationExpiresAt)}' : 'null'},"AvsPostalCodeResponseCode": ${avsPostalCodeResponseCode != null ? '${json.encode(avsPostalCodeResponseCode)}' : 'null'},"AvsStreetAddressResponseCode": ${avsStreetAddressResponseCode != null ? '${json.encode(avsStreetAddressResponseCode)}' : 'null'},"CreatedAt": ${createdAt != null ? '${json.encode(createdAt)}' : 'null'},"CurrencyIsoCode": ${currencyIsoCode != null ? '${json.encode(currencyIsoCode)}' : 'null'},"CvvResponseCode": ${cvvResponseCode != null ? '${json.encode(cvvResponseCode)}' : 'null'},"GraphQLId": ${graphQLId != null ? '${json.encode(graphQLId)}' : 'null'},"Id": ${id != null ? '${json.encode(id)}' : 'null'},"MerchantAccountId": ${merchantAccountId != null ? '${json.encode(merchantAccountId)}' : 'null'},"NetworkResponseCode": ${networkResponseCode != null ? '${json.encode(networkResponseCode)}' : 'null'},"NetworkResponseText": ${networkResponseText != null ? '${json.encode(networkResponseText)}' : 'null'},"NetworkTransactionId": ${networkTransactionId != null ? '${json.encode(networkTransactionId)}' : 'null'},"PlanId": ${planId != null ? '${json.encode(planId)}' : 'null'},"ProcessorAuthorizationCode": ${processorAuthorizationCode != null ? '${json.encode(processorAuthorizationCode)}' : 'null'},"ProcessorResponseCode": ${processorResponseCode != null ? '${json.encode(processorResponseCode)}' : 'null'},"ProcessorResponseText": ${processorResponseText != null ? '${json.encode(processorResponseText)}' : 'null'},"ProcessorSettlementResponseCode": ${processorSettlementResponseCode != null ? '${json.encode(processorSettlementResponseCode)}' : 'null'},"ProcessorSettlementResponseText": ${processorSettlementResponseText != null ? '${json.encode(processorSettlementResponseText)}' : 'null'},"SettlementBatchId": ${settlementBatchId != null ? '${json.encode(settlementBatchId)}' : 'null'},"SubscriptionId": ${subscriptionId != null ? '${json.encode(subscriptionId)}' : 'null'},"UpdatedAt": ${updatedAt != null ? '${json.encode(updatedAt)}' : 'null'},"AddOns": $addOns,"AuthorizationAdjustments": $authorizationAdjustments,"Discounts": $discounts,"Disputes": $disputes,"PartialSettlementTransactionIds": $partialSettlementTransactionIds,"RefundIds": $refundIds,"StatusHistory": $statusHistory,"AndroidPayDetails": $androidPayDetails,"BillingAddress": $billingAddress,"CreditCard": $creditCard,"CustomerDetails": $customerDetails,"Descriptor": $descriptor,"DisbursementDetails": $disbursementDetails,"EscrowStatus": $escrowStatus,"GatewayRejectionReason": $gatewayRejectionReason,"PayPalDetails": $payPalDetails,"PaymentInstrumentType": $paymentInstrumentType,"ProcessorResponseType": $processorResponseType,"ShippingAddress": $shippingAddress,"Status": $status,"SubscriptionDetails": $subscriptionDetails,"Type": $type}';
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
    customField = jsonRes['CustomField'];
    description = jsonRes['Description'];
    payeeEmail = jsonRes['PayeeEmail'];
    payeeId = jsonRes['PayeeId'];
    refundFromTransactionFeeAmount = jsonRes['RefundFromTransactionFeeAmount'];
    refundFromTransactionFeeCurrencyIsoCode =
        jsonRes['RefundFromTransactionFeeCurrencyIsoCode'];
    refundId = jsonRes['RefundId'];
    authorizationId = jsonRes['AuthorizationId'];
    captureId = jsonRes['CaptureId'];
    debugId = jsonRes['DebugId'];
    imageUrl = jsonRes['ImageUrl'];
    payerEmail = jsonRes['PayerEmail'];
    payerFirstName = jsonRes['PayerFirstName'];
    payerId = jsonRes['PayerId'];
    payerLastName = jsonRes['PayerLastName'];
    payerStatus = jsonRes['PayerStatus'];
    paymentId = jsonRes['PaymentId'];
    sellerProtectionStatus = jsonRes['SellerProtectionStatus'];
    token = jsonRes['Token'];
    transactionFeeAmount = jsonRes['TransactionFeeAmount'];
    transactionFeeCurrencyIsoCode = jsonRes['TransactionFeeCurrencyIsoCode'];
  }

  @override
  String toString() {
    return '{"CustomField": $customField,"Description": $description,"PayeeEmail": $payeeEmail,"PayeeId": $payeeId,"RefundFromTransactionFeeAmount": $refundFromTransactionFeeAmount,"RefundFromTransactionFeeCurrencyIsoCode": $refundFromTransactionFeeCurrencyIsoCode,"RefundId": $refundId,"AuthorizationId": ${authorizationId != null ? '${json.encode(authorizationId)}' : 'null'},"CaptureId": ${captureId != null ? '${json.encode(captureId)}' : 'null'},"DebugId": ${debugId != null ? '${json.encode(debugId)}' : 'null'},"ImageUrl": ${imageUrl != null ? '${json.encode(imageUrl)}' : 'null'},"PayerEmail": ${payerEmail != null ? '${json.encode(payerEmail)}' : 'null'},"PayerFirstName": ${payerFirstName != null ? '${json.encode(payerFirstName)}' : 'null'},"PayerId": ${payerId != null ? '${json.encode(payerId)}' : 'null'},"PayerLastName": ${payerLastName != null ? '${json.encode(payerLastName)}' : 'null'},"PayerStatus": ${payerStatus != null ? '${json.encode(payerStatus)}' : 'null'},"PaymentId": ${paymentId != null ? '${json.encode(paymentId)}' : 'null'},"SellerProtectionStatus": ${sellerProtectionStatus != null ? '${json.encode(sellerProtectionStatus)}' : 'null'},"Token": ${token != null ? '${json.encode(token)}' : 'null'},"TransactionFeeAmount": ${transactionFeeAmount != null ? '${json.encode(transactionFeeAmount)}' : 'null'},"TransactionFeeCurrencyIsoCode": ${transactionFeeCurrencyIsoCode != null ? '${json.encode(transactionFeeCurrencyIsoCode)}' : 'null'}}';
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
    countryOfIssuance = jsonRes['CountryOfIssuance'];
    globalId = jsonRes['GlobalId'];
    issuingBank = jsonRes['IssuingBank'];
    token = jsonRes['Token'];
    isNetworkTokenized = jsonRes['IsNetworkTokenized'];
    bin = jsonRes['Bin'];
    cardType = jsonRes['CardType'];
    commercial = jsonRes['Commercial'];
    debit = jsonRes['Debit'];
    durbinRegulated = jsonRes['DurbinRegulated'];
    expirationMonth = jsonRes['ExpirationMonth'];
    expirationYear = jsonRes['ExpirationYear'];
    googleTransactionId = jsonRes['GoogleTransactionId'];
    healthcare = jsonRes['Healthcare'];
    imageUrl = jsonRes['ImageUrl'];
    last4 = jsonRes['Last4'];
    payroll = jsonRes['Payroll'];
    prepaid = jsonRes['Prepaid'];
    productId = jsonRes['ProductId'];
    sourceCardLast4 = jsonRes['SourceCardLast4'];
    sourceCardType = jsonRes['SourceCardType'];
    sourceDescription = jsonRes['SourceDescription'];
    virtualCardLast4 = jsonRes['VirtualCardLast4'];
    virtualCardType = jsonRes['VirtualCardType'];
  }

  @override
  String toString() {
    return '{"CountryOfIssuance": $countryOfIssuance,"GlobalId": $globalId,"IssuingBank": $issuingBank,"Token": $token,"IsNetworkTokenized": $isNetworkTokenized,"Bin": ${bin != null ? '${json.encode(bin)}' : 'null'},"CardType": ${cardType != null ? '${json.encode(cardType)}' : 'null'},"Commercial": ${commercial != null ? '${json.encode(commercial)}' : 'null'},"Debit": ${debit != null ? '${json.encode(debit)}' : 'null'},"DurbinRegulated": ${durbinRegulated != null ? '${json.encode(durbinRegulated)}' : 'null'},"ExpirationMonth": ${expirationMonth != null ? '${json.encode(expirationMonth)}' : 'null'},"ExpirationYear": ${expirationYear != null ? '${json.encode(expirationYear)}' : 'null'},"GoogleTransactionId": ${googleTransactionId != null ? '${json.encode(googleTransactionId)}' : 'null'},"Healthcare": ${healthcare != null ? '${json.encode(healthcare)}' : 'null'},"ImageUrl": ${imageUrl != null ? '${json.encode(imageUrl)}' : 'null'},"Last4": ${last4 != null ? '${json.encode(last4)}' : 'null'},"Payroll": ${payroll != null ? '${json.encode(payroll)}' : 'null'},"Prepaid": ${prepaid != null ? '${json.encode(prepaid)}' : 'null'},"ProductId": ${productId != null ? '${json.encode(productId)}' : 'null'},"SourceCardLast4": ${sourceCardLast4 != null ? '${json.encode(sourceCardLast4)}' : 'null'},"SourceCardType": ${sourceCardType != null ? '${json.encode(sourceCardType)}' : 'null'},"SourceDescription": ${sourceDescription != null ? '${json.encode(sourceDescription)}' : 'null'},"VirtualCardLast4": ${virtualCardLast4 != null ? '${json.encode(virtualCardLast4)}' : 'null'},"VirtualCardType": ${virtualCardType != null ? '${json.encode(virtualCardType)}' : 'null'}}';
  }
}
