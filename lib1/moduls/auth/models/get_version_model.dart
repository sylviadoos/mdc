class VersionModel {
  int? status;
  bool? updated;
  String? message;
  int? version;

  VersionModel({this.status, this.message, this.version});

  VersionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['version'] = this.version;
    return data;
  }
}
