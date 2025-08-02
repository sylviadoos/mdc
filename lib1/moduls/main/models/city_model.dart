class CityModel {
  int? status;
  DataCity? data;
  String? message;

  CityModel({this.status, this.data, this.message});

  CityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new DataCity.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class DataCity {
  List<CityList>? cityList;

  DataCity({this.cityList});

  DataCity.fromJson(Map<String, dynamic> json) {
    if (json['cityList'] != null) {
      cityList = <CityList>[];
      json['cityList'].forEach((v) {
        cityList!.add(new CityList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cityList != null) {
      data['cityList'] = this.cityList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CityList {
  int? id;
  String? name;

  CityList({this.id, this.name});

  CityList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
