class QrOffersModel {
  int? status;
  Data? data;
  String? message;

  QrOffersModel({this.status, this.data, this.message});

  QrOffersModel.fromJson(Map<String, dynamic> json) {
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
  String? countryCode;
  String? phoneNumber;
  String? countryCode2;
  String? mobileNumber;
  String? address;
  String? street;
  String? apartment;
  String? office;
  String? city;
  String? state;
  String? country;
  String? addressLatitude;
  String? addressLongitude;
  String? facebookLink;
  String? instagramLink;
  String? twitterLink;
  String? dribbleLink;
  String? workingDays;
  String? startDay;
  String? endDay;
  String? closedDay;
  String? fullTime;
  String? startTime;
  String? endTime;
  String? services;
  String? qr;
  int? offerable;
  String? logo;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.name,
        this.description,
        this.countryCode,
        this.phoneNumber,
        this.countryCode2,
        this.mobileNumber,
        this.address,
        this.street,
        this.apartment,
        this.office,
        this.city,
        this.state,
        this.country,
        this.addressLatitude,
        this.addressLongitude,
        this.facebookLink,
        this.instagramLink,
        this.twitterLink,
        this.dribbleLink,
        this.workingDays,
        this.startDay,
        this.endDay,
        this.closedDay,
        this.fullTime,
        this.startTime,
        this.endTime,
        this.services,
        this.qr,
        this.offerable,
        this.logo,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    countryCode = json['country_code'];
    phoneNumber = json['phone_number'];
    countryCode2 = json['country_code2'];
    mobileNumber = json['mobile_number'];
    address = json['address'];
    street = json['street'];
    apartment = json['apartment'];
    office = json['office'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    addressLatitude = json['address_latitude'];
    addressLongitude = json['address_longitude'];
    facebookLink = json['facebook_link'];
    instagramLink = json['instagram_link'];
    twitterLink = json['twitter_link'];
    dribbleLink = json['dribble_link'];
    workingDays = json['working_days'];
    startDay = json['start_day'];
    endDay = json['end_day'];
    closedDay = json['closed_day'];
    fullTime = json['full_time'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    services = json['services'];
    qr = json['qr'];
    offerable = json['offerable'];
    logo = json['logo'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['country_code'] = this.countryCode;
    data['phone_number'] = this.phoneNumber;
    data['country_code2'] = this.countryCode2;
    data['mobile_number'] = this.mobileNumber;
    data['address'] = this.address;
    data['street'] = this.street;
    data['apartment'] = this.apartment;
    data['office'] = this.office;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['address_latitude'] = this.addressLatitude;
    data['address_longitude'] = this.addressLongitude;
    data['facebook_link'] = this.facebookLink;
    data['instagram_link'] = this.instagramLink;
    data['twitter_link'] = this.twitterLink;
    data['dribble_link'] = this.dribbleLink;
    data['working_days'] = this.workingDays;
    data['start_day'] = this.startDay;
    data['end_day'] = this.endDay;
    data['closed_day'] = this.closedDay;
    data['full_time'] = this.fullTime;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['services'] = this.services;
    data['qr'] = this.qr;
    data['offerable'] = this.offerable;
    data['logo'] = this.logo;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
