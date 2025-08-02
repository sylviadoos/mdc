class OfferPaymentModel {
  int? status;
  String? price;
  String? message;
  Result? result;

  OfferPaymentModel({this.status, this.price, this.message, this.result});

  OfferPaymentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    price = json['price'];
    message = json['message'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['price'] = this.price;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  int? orderId;
  String? url;

  Result({this.orderId, this.url});

  Result.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['url'] = this.url;
    return data;
  }
}
