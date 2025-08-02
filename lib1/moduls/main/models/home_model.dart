class HomeModel {
  int? status;
  Data? data;
  String? message;

  HomeModel({this.status, this.data, this.message});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  List<Offers>? offers;
  List<LatestOffers>? latestOffers;
  List<Suppliers>? suppliers;

  Data({this.offers, this.latestOffers, this.suppliers});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['offers'] != null) {
      offers = <Offers>[];
      json['offers'].forEach((v) {
        offers!.add(new Offers.fromJson(v));
      });
    }
    if (json['latestOffers'] != null) {
      latestOffers = <LatestOffers>[];
      json['latestOffers'].forEach((v) {
        latestOffers!.add(new LatestOffers.fromJson(v));
      });
    }
    if (json['suppliers'] != null) {
      suppliers = <Suppliers>[];
      json['suppliers'].forEach((v) {
        suppliers!.add(new Suppliers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.offers != null) {
      data['offers'] = this.offers!.map((v) => v.toJson()).toList();
    }
    if (this.latestOffers != null) {
      data['latestOffers'] = this.latestOffers!.map((v) => v.toJson()).toList();
    }
    if (this.suppliers != null) {
      data['suppliers'] = this.suppliers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Offers {
  int? id;
  String? image;
  String? hospitalId;

  Offers({this.id, this.image, this.hospitalId});

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    hospitalId = json['hospital_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['hospital_id'] = this.hospitalId;
    return data;
  }
}

class LatestOffers {
  int? id;
  String? title;
  String? description;
  String? image;
  int? hospitalId;
  String? status;

  LatestOffers(
      {this.id,
      this.title,
      this.description,
      this.image,
      this.hospitalId,
      this.status});

  LatestOffers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    hospitalId = json['hospital_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['hospital_id'] = this.hospitalId;
    data['status'] = this.status;
    return data;
  }
}

class Suppliers {
  int? hospitalId;
  String? name;
  String? image;
  String? status;

  Suppliers({this.hospitalId, this.name, this.image, this.status});

  Suppliers.fromJson(Map<String, dynamic> json) {
    hospitalId = json['hospital_id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hospital_id'] = this.hospitalId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}
