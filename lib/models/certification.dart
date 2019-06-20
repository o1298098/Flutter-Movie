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

  List<Order> AU;
  List<Order> BG;
  List<Order> BR;
  List<Order> CA;
  List<Order> CA_QC;
  List<Order> DE;
  List<Order> DK;
  List<Order> ES;
  List<Order> FI;
  List<Order> FR;
  List<Order> GB;
  List<Order> HU;
  List<Order> IN;
  List<Order> IT;
  List<Order> LT;
  List<Order> MY;
  List<Order> NL;
  List<Order> NO;
  List<Order> NZ;
  List<Order> PH;
  List<Order> PT;
  List<Order> RU;
  List<Order> SE;
  List<Order> US;

  Certification.fromParams({this.AU, this.BG, this.BR, this.CA, this.CA_QC, this.DE, this.DK, this.ES, this.FI, this.FR, this.GB, this.HU, this.IN, this.IT, this.LT, this.MY, this.NL, this.NO, this.NZ, this.PH, this.PT, this.RU, this.SE, this.US});
  
  Certification.fromJson(jsonRes) {
    AU = jsonRes['AU'] == null ? null : [];

    for (var AUItem in AU == null ? [] : jsonRes['AU']){
            AU.add(AUItem == null ? null : new Order.fromJson(AUItem));
    }

    BG = jsonRes['BG'] == null ? null : [];

    for (var BGItem in BG == null ? [] : jsonRes['BG']){
            BG.add(BGItem == null ? null : new Order.fromJson(BGItem));
    }

    BR = jsonRes['BR'] == null ? null : [];

    for (var BRItem in BR == null ? [] : jsonRes['BR']){
            BR.add(BRItem == null ? null : new Order.fromJson(BRItem));
    }

    CA = jsonRes['CA'] == null ? null : [];

    for (var CAItem in CA == null ? [] : jsonRes['CA']){
            CA.add(CAItem == null ? null : new Order.fromJson(CAItem));
    }

    CA_QC = jsonRes['CA-QC'] == null ? null : [];

    for (var CA_QCItem in CA_QC == null ? [] : jsonRes['CA-QC']){
            CA_QC.add(CA_QCItem == null ? null : new Order.fromJson(CA_QCItem));
    }

    DE = jsonRes['DE'] == null ? null : [];

    for (var DEItem in DE == null ? [] : jsonRes['DE']){
            DE.add(DEItem == null ? null : new Order.fromJson(DEItem));
    }

    DK = jsonRes['DK'] == null ? null : [];

    for (var DKItem in DK == null ? [] : jsonRes['DK']){
            DK.add(DKItem == null ? null : new Order.fromJson(DKItem));
    }

    ES = jsonRes['ES'] == null ? null : [];

    for (var ESItem in ES == null ? [] : jsonRes['ES']){
            ES.add(ESItem == null ? null : new Order.fromJson(ESItem));
    }

    FI = jsonRes['FI'] == null ? null : [];

    for (var FIItem in FI == null ? [] : jsonRes['FI']){
            FI.add(FIItem == null ? null : new Order.fromJson(FIItem));
    }

    FR = jsonRes['FR'] == null ? null : [];

    for (var FRItem in FR == null ? [] : jsonRes['FR']){
            FR.add(FRItem == null ? null : new Order.fromJson(FRItem));
    }

    GB = jsonRes['GB'] == null ? null : [];

    for (var GBItem in GB == null ? [] : jsonRes['GB']){
            GB.add(GBItem == null ? null : new Order.fromJson(GBItem));
    }

    HU = jsonRes['HU'] == null ? null : [];

    for (var HUItem in HU == null ? [] : jsonRes['HU']){
            HU.add(HUItem == null ? null : new Order.fromJson(HUItem));
    }

    IN = jsonRes['IN'] == null ? null : [];

    for (var INItem in IN == null ? [] : jsonRes['IN']){
            IN.add(INItem == null ? null : new Order.fromJson(INItem));
    }

    IT = jsonRes['IT'] == null ? null : [];

    for (var ITItem in IT == null ? [] : jsonRes['IT']){
            IT.add(ITItem == null ? null : new Order.fromJson(ITItem));
    }

    LT = jsonRes['LT'] == null ? null : [];

    for (var LTItem in LT == null ? [] : jsonRes['LT']){
            LT.add(LTItem == null ? null : new Order.fromJson(LTItem));
    }

    MY = jsonRes['MY'] == null ? null : [];

    for (var MYItem in MY == null ? [] : jsonRes['MY']){
            MY.add(MYItem == null ? null : new Order.fromJson(MYItem));
    }

    NL = jsonRes['NL'] == null ? null : [];

    for (var NLItem in NL == null ? [] : jsonRes['NL']){
            NL.add(NLItem == null ? null : new Order.fromJson(NLItem));
    }

    NO = jsonRes['NO'] == null ? null : [];

    for (var NOItem in NO == null ? [] : jsonRes['NO']){
            NO.add(NOItem == null ? null : new Order.fromJson(NOItem));
    }

    NZ = jsonRes['NZ'] == null ? null : [];

    for (var NZItem in NZ == null ? [] : jsonRes['NZ']){
            NZ.add(NZItem == null ? null : new Order.fromJson(NZItem));
    }

    PH = jsonRes['PH'] == null ? null : [];

    for (var PHItem in PH == null ? [] : jsonRes['PH']){
            PH.add(PHItem == null ? null : new Order.fromJson(PHItem));
    }

    PT = jsonRes['PT'] == null ? null : [];

    for (var PTItem in PT == null ? [] : jsonRes['PT']){
            PT.add(PTItem == null ? null : new Order.fromJson(PTItem));
    }

    RU = jsonRes['RU'] == null ? null : [];

    for (var RUItem in RU == null ? [] : jsonRes['RU']){
            RU.add(RUItem == null ? null : new Order.fromJson(RUItem));
    }

    SE = jsonRes['SE'] == null ? null : [];

    for (var SEItem in SE == null ? [] : jsonRes['SE']){
            SE.add(SEItem == null ? null : new Order.fromJson(SEItem));
    }

    US = jsonRes['US'] == null ? null : [];

    for (var USItem in US == null ? [] : jsonRes['US']){
            US.add(USItem == null ? null : new Order.fromJson(USItem));
    }
  }

  @override
  String toString() {
    return '{"AU": $AU,"BG": $BG,"BR": $BR,"CA": $CA,"CA-QC": $CA-QC,"DE": $DE,"DK": $DK,"ES": $ES,"FI": $FI,"FR": $FR,"GB": $GB,"HU": $HU,"IN": $IN,"IT": $IT,"LT": $LT,"MY": $MY,"NL": $NL,"NO": $NO,"NZ": $NZ,"PH": $PH,"PT": $PT,"RU": $RU,"SE": $SE,"US": $US}';
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

