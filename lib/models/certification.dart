import 'dart:convert' show json;

class CertificationModel {

  Certification certifications;

  CertificationModel.fromParams({this.certifications});

  factory CertificationModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new CertificationModel.fromJson(json.decode(jsonStr)) : new CertificationModel.fromJson(jsonStr);
  
  CertificationModel.fromJson(jsonRes) {
    certifications = jsonRes['certifications'] == null ? null : new Certification.fromJson(jsonRes['certifications']);
  }

  @override
  String toString() {
    return '{"certifications": $certifications}';
  }
}

class Certification {

  List<Order> au;
  List<Order> bg;
  List<Order> br;
  List<Order> ca;
  List<Order> caQc;
  List<Order> de;
  List<Order> dk;
  List<Order> es;
  List<Order> fi;
  List<Order> fr;
  List<Order> gb;
  List<Order> hu;
  List<Order> inn;
  List<Order> it;
  List<Order> lt;
  List<Order> my;
  List<Order> nl;
  List<Order> no;
  List<Order> nz;
  List<Order> ph;
  List<Order> pt;
  List<Order> ru;
  List<Order> se;
  List<Order> us;

  Certification.fromParams({this.au, this.bg, this.br, this.ca, this.caQc, this.de, this.dk, this.es, this.fi, this.fr, this.gb, this.hu, this.inn, this.it, this.lt, this.my, this.nl, this.no, this.nz, this.ph, this.pt, this.ru, this.se, this.us});
  
  Certification.fromJson(jsonRes) {
    au = jsonRes['AU'] == null ? null : [];

    for (var AUItem in au == null ? [] : jsonRes['AU']){
            au.add(AUItem == null ? null : new Order.fromJson(AUItem));
    }

    bg = jsonRes['BG'] == null ? null : [];

    for (var BGItem in bg == null ? [] : jsonRes['BG']){
            bg.add(BGItem == null ? null : new Order.fromJson(BGItem));
    }

    br = jsonRes['BR'] == null ? null : [];

    for (var BRItem in br == null ? [] : jsonRes['BR']){
            br.add(BRItem == null ? null : new Order.fromJson(BRItem));
    }

    ca = jsonRes['CA'] == null ? null : [];

    for (var CAItem in ca == null ? [] : jsonRes['CA']){
            ca.add(CAItem == null ? null : new Order.fromJson(CAItem));
    }

    caQc = jsonRes['CA-QC'] == null ? null : [];

    for (var CA_QCItem in caQc == null ? [] : jsonRes['CA-QC']){
            caQc.add(CA_QCItem == null ? null : new Order.fromJson(CA_QCItem));
    }

    de = jsonRes['DE'] == null ? null : [];

    for (var DEItem in de == null ? [] : jsonRes['DE']){
            de.add(DEItem == null ? null : new Order.fromJson(DEItem));
    }

    dk = jsonRes['DK'] == null ? null : [];

    for (var DKItem in dk == null ? [] : jsonRes['DK']){
            dk.add(DKItem == null ? null : new Order.fromJson(DKItem));
    }

    es = jsonRes['ES'] == null ? null : [];

    for (var ESItem in es == null ? [] : jsonRes['ES']){
            es.add(ESItem == null ? null : new Order.fromJson(ESItem));
    }

    fi = jsonRes['FI'] == null ? null : [];

    for (var FIItem in fi == null ? [] : jsonRes['FI']){
            fi.add(FIItem == null ? null : new Order.fromJson(FIItem));
    }

    fr = jsonRes['FR'] == null ? null : [];

    for (var FRItem in fr == null ? [] : jsonRes['FR']){
            fr.add(FRItem == null ? null : new Order.fromJson(FRItem));
    }

    gb = jsonRes['GB'] == null ? null : [];

    for (var GBItem in gb == null ? [] : jsonRes['GB']){
            gb.add(GBItem == null ? null : new Order.fromJson(GBItem));
    }

    hu = jsonRes['HU'] == null ? null : [];

    for (var HUItem in hu == null ? [] : jsonRes['HU']){
            hu.add(HUItem == null ? null : new Order.fromJson(HUItem));
    }

    inn = jsonRes['IN'] == null ? null : [];

    for (var INItem in inn == null ? [] : jsonRes['IN']){
            inn.add(INItem == null ? null : new Order.fromJson(INItem));
    }

    it = jsonRes['IT'] == null ? null : [];

    for (var ITItem in it == null ? [] : jsonRes['IT']){
            it.add(ITItem == null ? null : new Order.fromJson(ITItem));
    }

    lt = jsonRes['LT'] == null ? null : [];

    for (var LTItem in lt == null ? [] : jsonRes['LT']){
            lt.add(LTItem == null ? null : new Order.fromJson(LTItem));
    }

    my = jsonRes['MY'] == null ? null : [];

    for (var MYItem in my == null ? [] : jsonRes['MY']){
            my.add(MYItem == null ? null : new Order.fromJson(MYItem));
    }

    nl = jsonRes['NL'] == null ? null : [];

    for (var NLItem in nl == null ? [] : jsonRes['NL']){
            nl.add(NLItem == null ? null : new Order.fromJson(NLItem));
    }

    no = jsonRes['NO'] == null ? null : [];

    for (var NOItem in no == null ? [] : jsonRes['NO']){
            no.add(NOItem == null ? null : new Order.fromJson(NOItem));
    }

    nz = jsonRes['NZ'] == null ? null : [];

    for (var NZItem in nz == null ? [] : jsonRes['NZ']){
            nz.add(NZItem == null ? null : new Order.fromJson(NZItem));
    }

    ph = jsonRes['PH'] == null ? null : [];

    for (var PHItem in ph == null ? [] : jsonRes['PH']){
            ph.add(PHItem == null ? null : new Order.fromJson(PHItem));
    }

    pt = jsonRes['PT'] == null ? null : [];

    for (var PTItem in pt == null ? [] : jsonRes['PT']){
            pt.add(PTItem == null ? null : new Order.fromJson(PTItem));
    }

    ru = jsonRes['RU'] == null ? null : [];

    for (var RUItem in ru == null ? [] : jsonRes['RU']){
            ru.add(RUItem == null ? null : new Order.fromJson(RUItem));
    }

    se = jsonRes['SE'] == null ? null : [];

    for (var SEItem in se == null ? [] : jsonRes['SE']){
            se.add(SEItem == null ? null : new Order.fromJson(SEItem));
    }

    us = jsonRes['US'] == null ? null : [];

    for (var USItem in us == null ? [] : jsonRes['US']){
            us.add(USItem == null ? null : new Order.fromJson(USItem));
    }
  }

  @override
  String toString() {
    return '{"AU": $au,"BG": $bg,"BR": $br,"CA": $ca,"CA-QC": $ca-QC,"DE": $de,"DK": $dk,"ES": $es,"FI": $fi,"FR": $fr,"GB": $gb,"HU": $hu,"IN": $inn,"IT": $it,"LT": $lt,"MY": $my,"NL": $nl,"NO": $no,"NZ": $nz,"PH": $ph,"PT": $pt,"RU": $ru,"SE": $se,"US": $us}';
  }
}

class Order {

  int order;
  String certification;
  String meaning;

  Order.fromParams({this.order, this.certification, this.meaning});
  
  Order.fromJson(jsonRes) {
    order = jsonRes['order'];
    certification = jsonRes['certification'];
    meaning = jsonRes['meaning'];
  }

  @override
  String toString() {
    return '{"order": $order,"certification": ${certification != null?'${json.encode(certification)}':'null'},"meaning": ${meaning != null?'${json.encode(meaning)}':'null'}}';
  }
}

