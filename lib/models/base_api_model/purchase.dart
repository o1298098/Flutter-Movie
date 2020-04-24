class Purchase {
  String userId;
  double amount;
  String paymentMethodNonce;
  String deviceData;
  Purchase(
      {this.amount, this.deviceData, this.paymentMethodNonce, this.userId});
}
