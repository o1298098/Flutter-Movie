import 'dart:convert' show json;

class ProductionCompanie {
  int id;
  String logoPath;
  String name;
  String originCountry;

  ProductionCompanie.fromParams(
      {this.id, this.logoPath, this.name, this.originCountry});

  ProductionCompanie.fromJson(jsonRes) {
    id = jsonRes['id'];
    logoPath = jsonRes['logo_path'];
    name = jsonRes['name'];
    originCountry = jsonRes['origin_country'];
  }

  @override
  String toString() {
    return '{"id": $id,"logo_path": ${logoPath != null ? '${json.encode(logoPath)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"origin_country": ${originCountry != null ? '${json.encode(originCountry)}' : 'null'}}';
  }
}
