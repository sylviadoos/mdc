class OffersModel {
  int? status;
  List<DataOffer>? data;
  String? message;

  OffersModel({this.status, this.data, this.message});

  OffersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DataOffer>[];
      json['data'].forEach((v) {
        data!.add(new DataOffer.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class DataOffer {
  int? id;
  String? name;
  String? description;
  String? city;
  String? logo;

  DataOffer({this.id, this.name, this.description, this.city, this.logo});

  DataOffer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    city = json['city'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['city'] = this.city;
    data['logo'] = this.logo;
    return data;
  }
}
