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
