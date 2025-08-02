class InformationCardSingle {
  int? _status;
  String? _price;
  String? _message;
  Result? _result;

  InformationCardSingle(
      {int? status, String? price, String? message, Result? result}) {
    if (status != null) {
      this._status = status;
    }
    if (price != null) {
      this._price = price;
    }
    if (message != null) {
      this._message = message;
    }
    if (result != null) {
      this._result = result;
    }
  }

  int? get status => _status;
  set status(int? status) => _status = status;
  String? get price => _price;
  set price(String? price) => _price = price;
  String? get message => _message;
  set message(String? message) => _message = message;
  Result? get result => _result;
  set result(Result? result) => _result = result;

  InformationCardSingle.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _price = json['price'];
    _message = json['message'];
    _result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['price'] = this._price;
    data['message'] = this._message;
    if (this._result != null) {
      data['result'] = this._result!.toJson();
    }
    return data;
  }
}

class Result {
  int? _orderId;
  String? _url;

  Result({int? orderId, String? url}) {
    if (orderId != null) {
      this._orderId = orderId;
    }
    if (url != null) {
      this._url = url;
    }
  }

  int? get orderId => _orderId;
  set orderId(int? orderId) => _orderId = orderId;
  String? get url => _url;
  set url(String? url) => _url = url;

  Result.fromJson(Map<String, dynamic> json) {
    _orderId = json['order_id'];
    _url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this._orderId;
    data['url'] = this._url;
    return data;
  }
}
