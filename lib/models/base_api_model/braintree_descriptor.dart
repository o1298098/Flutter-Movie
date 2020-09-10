class BraintreeDescriptor {
  Object name;
  Object phone;
  Object url;

  BraintreeDescriptor.fromParams({this.name, this.phone, this.url});

  BraintreeDescriptor.fromJson(jsonRes) {
    name = jsonRes['Name'];
    phone = jsonRes['Phone'];
    url = jsonRes['Url'];
  }

  @override
  String toString() {
    return '{"Name": $name,"Phone": $phone,"Url": $url}';
  }
}
