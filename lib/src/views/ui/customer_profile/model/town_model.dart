class TownModel {
  List<TownList> townList;

  TownModel({this.townList});

  TownModel.fromJson(Map<String, dynamic> json) {
    if (json['town_list'] != null) {
      townList = [];
      json['town_list'].forEach((v) {
        townList.add(new TownList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.townList != null) {
      data['town_list'] = this.townList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TownList {
  int townId;
  String townName;

  TownList({this.townId, this.townName});

  TownList.fromJson(Map<String, dynamic> json) {
    townId = json['town_id'];
    townName = json['town_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['town_id'] = this.townId;
    data['town_name'] = this.townName;
    return data;
  }
}
