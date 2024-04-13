class NotificationModel {
  int? status;
  List<Data>? data;
  String? message;

  NotificationModel({this.status, this.data, this.message});

  NotificationModel.fromJson(Map<String, dynamic> json) {
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
  String? message;
  String? notificationType;
  String? readStatus;

  Data(
      {this.id,
      this.title,
      this.message,
      this.notificationType,
      this.readStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    notificationType = json['notification_type'];
    readStatus = json['read_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['message'] = this.message;
    data['notification_type'] = this.notificationType;
    data['read_status'] = this.readStatus;
    return data;
  }
}
