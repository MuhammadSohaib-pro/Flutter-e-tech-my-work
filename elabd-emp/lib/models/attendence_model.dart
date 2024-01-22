class AttendenceModel {
  String? key;
  String? value;

  AttendenceModel({this.key, this.value});

  AttendenceModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json["value"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["key"] = key;
    data["value"] = value;
    return data;
  }
}
