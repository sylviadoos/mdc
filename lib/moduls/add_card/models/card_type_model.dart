class CardTypeModel {
  int? status;
  List<Data>? data;
  String? message;

  CardTypeModel({this.status, this.data, this.message});

  CardTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  String? name;
  String? price;
  String? status;
  dynamic is_to_all;

  Data({this.id, this.name, this.price, this.status,this.is_to_all});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    status = json['status'];
    is_to_all = json['is_to_all'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['status'] = this.status;
    data['is_to_all'] = this.is_to_all;

    return data;
  }
}
