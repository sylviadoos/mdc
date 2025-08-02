class CardModel {
  int? status;
  List<DataCards>? data;
  String? message;

  CardModel({this.status, this.data, this.message});

  CardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DataCards>[];
      json['data'].forEach((v) {
        data!.add(new DataCards.fromJson(v));
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

class DataCards {
  int? id;
  String? fullname;
  String? policy;
  String? gccId;
  String? cardStatus;
  String? createdDate;
  String? acceptedDate;
  String? expiredDate;

  DataCards(
      {this.id,
      this.fullname,
      this.policy,
      this.gccId,
      this.cardStatus,
      this.createdDate,
      this.acceptedDate,
      this.expiredDate});

  DataCards.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    policy = json['policy'];
    gccId = json['gcc_id'];
    cardStatus = json['card_status'];
    createdDate = json['created_date'];
    acceptedDate = json['accepted_date'];
    expiredDate = json['expired_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['policy'] = this.policy;
    data['gcc_id'] = this.gccId;
    data['card_status'] = this.cardStatus;
    data['created_date'] = this.createdDate;
    data['accepted_date'] = this.acceptedDate;
    data['expired_date'] = this.expiredDate;
    return data;
  }
}
