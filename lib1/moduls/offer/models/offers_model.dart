class OffersModel {
  int? status;
  List<Data>? data;
  String? message;

  OffersModel({this.status, this.data, this.message});

  OffersModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? image;
  String? description;
  String? hospitalId;
  String? serviceId;
  int? priceBefore;
  int? priceAfter;
  int? priceAfterMdc;
  String? userId;
  String? startDate;
  String? status;
  String? createdAt;
  String? updatedAt;
  bool offerTaken = false;

  Data(
      {this.id,
      this.title,
      this.image,
      this.description,
      this.hospitalId,
      this.serviceId,
      this.priceBefore,
      this.priceAfter,
      this.priceAfterMdc,
      this.userId,
      this.startDate,
      this.status,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    hospitalId = json['hospital_id'];
    serviceId = json['service_id'];
    priceBefore = json['price_before'];
    priceAfter = json['price_after'];
    priceAfterMdc = json['price_after_mdc'];
    userId = json['user_id'];
    startDate = json['start_date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['description'] = this.description;
    data['hospital_id'] = this.hospitalId;
    data['service_id'] = this.serviceId;
    data['price_before'] = this.priceBefore;
    data['price_after'] = this.priceAfter;
    data['price_after_mdc'] = this.priceAfterMdc;
    data['user_id'] = this.userId;
    data['start_date'] = this.startDate;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
