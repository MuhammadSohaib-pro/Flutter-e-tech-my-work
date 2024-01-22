// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);
import 'dart:convert';

LeaveRquestModel notificationModelFromJson(String str) =>
    LeaveRquestModel.fromJson(json.decode(str));

String notificationModelToJson(LeaveRquestModel data) =>
    json.encode(data.toJson());

class LeaveRquestModel {
  String? image;
  String? receiveToken;
  String? notes;
  String? leaveDate;
  bool? isRead;
  String? name;
  String? currentDate;
  String? team;
  String? userId;
  String? leaveSelectedValue;
  String? desc;
  String? status;

  LeaveRquestModel(
      {this.image,
      this.receiveToken,
      this.notes,
      this.leaveDate,
      this.isRead,
      this.name,
      this.currentDate,
      this.team,
      this.userId,
      this.leaveSelectedValue,
      this.desc,
      this.status});

  LeaveRquestModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    receiveToken = json['receiveToken'];
    notes = json['notes'];
    leaveDate = json['leaveDate'];
    isRead = json['isRead'];
    name = json['name'];
    currentDate = json['currentDate'];
    team = json['team'];
    userId = json['userId'];
    leaveSelectedValue = json['leaveSelectedValue'];
    desc = json['desc'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['receiveToken'] = receiveToken;
    data['notes'] = notes;
    data['leaveDate'] = leaveDate;
    data['isRead'] = isRead;
    data['name'] = name;
    data['currentDate'] = currentDate;
    data['team'] = team;
    data['userId'] = userId;
    data['leaveSelectedValue'] = leaveSelectedValue;
    data['desc'] = desc;
    data['status'] = status;
    return data;
  }
}
