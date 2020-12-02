class StripeAddress {
  String city;
  String country;
  String line1;
  String line2;
  String postalCode;
  String state;

  StripeAddress(
      {this.city,
      this.country,
      this.line1,
      this.line2,
      this.postalCode,
      this.state});

  StripeAddress.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    country = json['country'];
    line1 = json['line1'];
    line2 = json['line2'];
    postalCode = json['postal_code'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['country'] = this.country;
    data['line1'] = this.line1;
    data['line2'] = this.line2;
    data['postal_code'] = this.postalCode;
    data['state'] = this.state;
    return data;
  }
}
