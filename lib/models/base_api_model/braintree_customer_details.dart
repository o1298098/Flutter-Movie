import 'dart:convert' show json;

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
