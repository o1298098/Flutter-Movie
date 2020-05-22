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
    company = jsonRes['Company'];
    countryCodeAlpha2 = jsonRes['CountryCodeAlpha2'];
    countryCodeAlpha3 = jsonRes['CountryCodeAlpha3'];
    countryCodeNumeric = jsonRes['CountryCodeNumeric'];
    countryName = jsonRes['CountryName'];
    createdAt = jsonRes['CreatedAt'];
    customerId = jsonRes['CustomerId'];
    extendedAddress = jsonRes['ExtendedAddress'];
    firstName = jsonRes['FirstName'];
    id = jsonRes['Id'];
    lastName = jsonRes['LastName'];
    locality = jsonRes['Locality'];
    postalCode = jsonRes['PostalCode'];
    region = jsonRes['Region'];
    streetAddress = jsonRes['StreetAddress'];
    updatedAt = jsonRes['UpdatedAt'];
  }

  @override
  String toString() {
    return '{"Company": $company,"CountryCodeAlpha2": $countryCodeAlpha2,"CountryCodeAlpha3": $countryCodeAlpha3,"CountryCodeNumeric": $countryCodeNumeric,"CountryName": $countryName,"CreatedAt": $createdAt,"CustomerId": $customerId,"ExtendedAddress": $extendedAddress,"FirstName": $firstName,"Id": $id,"LastName": $lastName,"Locality": $locality,"PostalCode": $postalCode,"Region": $region,"StreetAddress": $streetAddress,"UpdatedAt": $updatedAt}';
  }
}
