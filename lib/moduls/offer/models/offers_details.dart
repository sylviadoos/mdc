class DetailsOffersModel {
  int? status;
  Data? data;
  String? message;

  DetailsOffersModel({this.status, this.data, this.message});

  DetailsOffersModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  String? description;
  String? logo;
  String? fullTime;
  String? startDay;
  String? endDay;
  String? closedDay;
  String? startTime;
  String? endTime;
  String? phoneNumberCountrycode;
  String? phoneNumber;
  String? mobileNumberCountrycode;
  String? mobileNumber;
  String? facebookLink;
  String? instagramLink;
  String? twitterLink;
  String? dribbleLink;
  String? addressLattitude;
  String? addressLongitude;
  String? address;
  List<SliderImages>? sliderImages;
  List<Services>? services;

  Data(
      {this.id,
      this.name,
      this.description,
      this.logo,
      this.fullTime,
      this.startDay,
      this.endDay,
      this.closedDay,
      this.startTime,
      this.endTime,
      this.phoneNumberCountrycode,
      this.phoneNumber,
      this.mobileNumberCountrycode,
      this.mobileNumber,
      this.facebookLink,
      this.instagramLink,
      this.twitterLink,
      this.dribbleLink,
      this.addressLattitude,
      this.addressLongitude,
      this.address,
      this.sliderImages,
      this.services});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    logo = json['logo'];
    fullTime = json['full_time'];
    startDay = json['start_day'];
    endDay = json['end_day'];
    closedDay = json['closed_day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    phoneNumberCountrycode = json['phone_number_countrycode'];
    phoneNumber = json['phone_number'];
    mobileNumberCountrycode = json['mobile_number_countrycode'];
    mobileNumber = json['mobile_number'];
    facebookLink = json['facebook_link'];
    instagramLink = json['instagram_link'];
    twitterLink = json['twitter_link'];
    dribbleLink = json['dribble_link'];
    addressLattitude = json['address_lattitude'];
    addressLongitude = json['address_longitude'];
    address = json['address'];
    if (json['slider_images'] != null) {
      sliderImages = <SliderImages>[];
      json['slider_images'].forEach((v) {
        sliderImages!.add(new SliderImages.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['logo'] = this.logo;
    data['full_time'] = this.fullTime;
    data['start_day'] = this.startDay;
    data['end_day'] = this.endDay;
    data['closed_day'] = this.closedDay;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['phone_number_countrycode'] = this.phoneNumberCountrycode;
    data['phone_number'] = this.phoneNumber;
    data['mobile_number_countrycode'] = this.mobileNumberCountrycode;
    data['mobile_number'] = this.mobileNumber;
    data['facebook_link'] = this.facebookLink;
    data['instagram_link'] = this.instagramLink;
    data['twitter_link'] = this.twitterLink;
    data['dribble_link'] = this.dribbleLink;
    data['address_lattitude'] = this.addressLattitude;
    data['address_longitude'] = this.addressLongitude;
    data['address'] = this.address;
    if (this.sliderImages != null) {
      data['slider_images'] =
          this.sliderImages!.map((v) => v.toJson()).toList();
    }
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SliderImages {
  int? id;
  String? image;

  SliderImages({this.id, this.image});

  SliderImages.fromJson(Map<String, dynamic> json) {
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

class Services {
  int? id;
  String? name;
  String? priceBeforeDiscount;
  String? priceAfterDiscount;

  Services(
      {this.id, this.name, this.priceBeforeDiscount, this.priceAfterDiscount});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    priceBeforeDiscount = json['price_before_discount'];
    priceAfterDiscount = json['price_after_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price_before_discount'] = this.priceBeforeDiscount;
    data['price_after_discount'] = this.priceAfterDiscount;
    return data;
  }
}
