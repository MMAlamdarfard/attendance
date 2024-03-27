class GeoLocation {
  List<Building>? building;

  GeoLocation({this.building});

  GeoLocation.fromJson(Map<String, dynamic> json) {
    if (json['building'] != null) {
      building = <Building>[];
      json['building'].forEach((v) {
        building!.add(Building.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (building != null) {
      data['building'] = building!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Building {
  List<String>? bssidWifi;
  String? sId;
  String? name;
  int? number;
  String? jsonData;
  int? iV;

  Building(
      {this.bssidWifi, this.sId, this.name, this.number, this.jsonData, this.iV});

  Building.fromJson(Map<String, dynamic> json) {
    bssidWifi = json['BssidWifi'].cast<String>();
    sId = json['_id'];
    name = json['Name'];
    number = json['Number'];
    jsonData = json['Json'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BssidWifi'] = bssidWifi;
    data['_id'] = sId;
    data['Name'] = name;
    data['Number'] = number;
    data['Json'] = jsonData;
    data['__v'] = iV;
    return data;
  }
}