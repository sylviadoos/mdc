class AllUserOffers {
  int? status;
  List<Data>? data;
  String? message;

  AllUserOffers({this.status, this.data, this.message});

  AllUserOffers.fromJson(Map<String, dynamic> json) {
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
  String? description;
  String? logo;
  String? expireDate;
  int? priceBeforeDis;
  int? priceAfterdis;
  int? priceAfterdisMdc;
  String? hospitalName;
  int? hospitalId;
  SliderImagesHospital? sliderImagesHospital;
  int? serviceId;
  String? serviceName;
  int? status;

  Data(
      {this.id,
        this.name,
        this.description,
        this.logo,
        this.expireDate,
        this.priceBeforeDis,
        this.priceAfterdis,
        this.priceAfterdisMdc,
        this.hospitalName,
        this.hospitalId,
        this.sliderImagesHospital,
        this.serviceId,
        this.serviceName,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    logo = json['logo'];
    expireDate = json['expire_date'];
    priceBeforeDis = json['price_beforeDis'];
    priceAfterdis = json['price_afterdis'];
    priceAfterdisMdc = json['price_afterdis_Mdc'];
    hospitalName = json['hospital_name'];
    hospitalId = json['hospital_id'];
    sliderImagesHospital = json['slider_images_hospital'] != null
        ? new SliderImagesHospital.fromJson(json['slider_images_hospital'])
        : null;
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['logo'] = this.logo;
    data['expire_date'] = this.expireDate;
    data['price_beforeDis'] = this.priceBeforeDis;
    data['price_afterdis'] = this.priceAfterdis;
    data['price_afterdis_Mdc'] = this.priceAfterdisMdc;
    data['hospital_name'] = this.hospitalName;
    data['hospital_id'] = this.hospitalId;
    if (this.sliderImagesHospital != null) {
      data['slider_images_hospital'] = this.sliderImagesHospital!.toJson();
    }
    data['service_id'] = this.serviceId;
    data['service_name'] = this.serviceName;
    data['status'] = this.status;
    return data;
  }
}

class SliderImagesHospital {
  int? id;
  String? image;

  SliderImagesHospital({this.id, this.image});

  SliderImagesHospital.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}
