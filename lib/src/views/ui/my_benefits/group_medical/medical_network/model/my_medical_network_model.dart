class MyMedicalNetworkModel {
  String network;
  ContactSupport contactSupport;
  List<Provider> provider;

  MyMedicalNetworkModel({this.network, this.contactSupport, this.provider});

  MyMedicalNetworkModel.fromJson(Map<String, dynamic> json) {
    network = json['Network'];
    contactSupport = json['ContactSupport'] != null
        ? new ContactSupport.fromJson(json['ContactSupport'])
        : null;
    if (json['Provider'] != null) {
      provider = [];
      json['Provider'].forEach((v) {
        provider.add(new Provider.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Network'] = this.network;
    if (this.contactSupport != null) {
      data['ContactSupport'] = this.contactSupport.toJson();
    }
    if (this.provider != null) {
      data['Provider'] = this.provider.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContactSupport {
  String local;
  String international;

  ContactSupport({this.local, this.international});

  ContactSupport.fromJson(Map<String, dynamic> json) {
    local = json['Local'];
    international = json['International'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Local'] = this.local;
    data['International'] = this.international;
    return data;
  }
}

class Provider {
  String pROVIDERNAME;
  String pROVIDERID;
  String lATITUDE;
  String lONGITUDE;
  String cITYDESCRIPTION;
  String cOUNTRYDESCRIPTION;
  String sPECIALITYDESCRIPTION;
  String pHONENUMBER1;
  String pROVIDERTYPEDESCRIPTION;
  String bRANCHID;
  List<BRANCHES> bRANCHES;

  Provider(
      {this.pROVIDERNAME,
      this.pROVIDERID,
      this.lATITUDE,
      this.lONGITUDE,
      this.cITYDESCRIPTION,
      this.cOUNTRYDESCRIPTION,
      this.sPECIALITYDESCRIPTION,
      this.pHONENUMBER1,
      this.pROVIDERTYPEDESCRIPTION,
      this.bRANCHID,
      this.bRANCHES});

  Provider.fromJson(Map<String, dynamic> json) {
    pROVIDERNAME = json['PROVIDER_NAME'];
    pROVIDERID = json['PROVIDER_ID'];
    lATITUDE = json['LATITUDE'];
    lONGITUDE = json['LONGITUDE'];
    cITYDESCRIPTION = json['CITY_DESCRIPTION'];
    cOUNTRYDESCRIPTION = json['COUNTRY_DESCRIPTION'];
    sPECIALITYDESCRIPTION = json['SPECIALITY_DESCRIPTION'];
    pHONENUMBER1 = json['PHONE_NUMBER1'];
    pROVIDERTYPEDESCRIPTION = json['PROVIDER_TYPE_DESCRIPTION'];
    bRANCHID = json['BRANCH_ID'];
    if (json['BRANCHES'] != null) {
      bRANCHES = [];
      json['BRANCHES'].forEach((v) {
        bRANCHES.add(new BRANCHES.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PROVIDER_NAME'] = this.pROVIDERNAME;
    data['PROVIDER_ID'] = this.pROVIDERID;
    data['LATITUDE'] = this.lATITUDE;
    data['LONGITUDE'] = this.lONGITUDE;
    data['CITY_DESCRIPTION'] = this.cITYDESCRIPTION;
    data['COUNTRY_DESCRIPTION'] = this.cOUNTRYDESCRIPTION;
    data['SPECIALITY_DESCRIPTION'] = this.sPECIALITYDESCRIPTION;
    data['PHONE_NUMBER1'] = this.pHONENUMBER1;
    data['PROVIDER_TYPE_DESCRIPTION'] = this.pROVIDERTYPEDESCRIPTION;
    data['BRANCH_ID'] = this.bRANCHID;
    if (this.bRANCHES != null) {
      data['BRANCHES'] = this.bRANCHES.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BRANCHES {
  int iD;
  String pROVIDERID;
  String bRANCHID;
  String cOUNTRYDESCRIPTION;
  String cITYDESCRIPTION;
  String pHONENUMBER1;
  String lONGITUDE;
  String lATITUDE;
  String bRANCHNAME;
  String tYPEDESCRIPTION;
  String sPECIALITYDESCRIPTION;
  String nETWORKID;

  BRANCHES(
      {this.iD,
      this.pROVIDERID,
      this.bRANCHID,
      this.cOUNTRYDESCRIPTION,
      this.cITYDESCRIPTION,
      this.pHONENUMBER1,
      this.lONGITUDE,
      this.lATITUDE,
      this.bRANCHNAME,
      this.tYPEDESCRIPTION,
      this.sPECIALITYDESCRIPTION,
      this.nETWORKID});

  BRANCHES.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    pROVIDERID = json['PROVIDER_ID'];
    bRANCHID = json['BRANCH_ID'];
    cOUNTRYDESCRIPTION = json['COUNTRY_DESCRIPTION'];
    cITYDESCRIPTION = json['CITY_DESCRIPTION'];
    pHONENUMBER1 = json['PHONE_NUMBER1'];
    lONGITUDE = json['LONGITUDE'];
    lATITUDE = json['LATITUDE'];
    bRANCHNAME = json['BRANCH_NAME'];
    tYPEDESCRIPTION = json['TYPE_DESCRIPTION'];
    sPECIALITYDESCRIPTION = json['SPECIALITY_DESCRIPTION'];
    nETWORKID = json['NETWORK_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['PROVIDER_ID'] = this.pROVIDERID;
    data['BRANCH_ID'] = this.bRANCHID;
    data['COUNTRY_DESCRIPTION'] = this.cOUNTRYDESCRIPTION;
    data['CITY_DESCRIPTION'] = this.cITYDESCRIPTION;
    data['PHONE_NUMBER1'] = this.pHONENUMBER1;
    data['LONGITUDE'] = this.lONGITUDE;
    data['LATITUDE'] = this.lATITUDE;
    data['BRANCH_NAME'] = this.bRANCHNAME;
    data['TYPE_DESCRIPTION'] = this.tYPEDESCRIPTION;
    data['SPECIALITY_DESCRIPTION'] = this.sPECIALITYDESCRIPTION;
    data['NETWORK_ID'] = this.nETWORKID;
    return data;
  }
}
