// // To parse this JSON data, do
// //
// //     final userModel = userModelFromJson(jsonString);

// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';

// UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

// String userModelToJson(UserModel data) => json.encode(data.toJson());

// class UserModel {
//   String name;
//   String email;
//   String address;
//   String contact;
//   Timestamp date;
//   String id;
//   String fcmToken;
//   String image;
//   String joinDate;
//   String lastMessageTime;
//   String status;
//   String role;
//   String team;
//   String teamId;
//   String type;

//   UserModel({
//     required this.name,
//     required this.email,
//     required this.address,
//     required this.contact,
//     required this.date,
//     required this.id,
//     required this.fcmToken,
//     required this.image,
//     required this.joinDate,
//     required this.lastMessageTime,
//     required this.status,
//     required this.role,
//     required this.team,
//     required this.teamId,
//     required this.type,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     Timestamp? dateTimestamp;

//     if (json['date'] is Timestamp) {
//       dateTimestamp = json['date'];
//     } else if (json['date'] != null) {
//       dateTimestamp = Timestamp.fromMillisecondsSinceEpoch(json['date']);
//     }
//     return UserModel(
//       name: json["name"],
//       email: json["email"],
//       address: json["address"],
//       contact: json["contact"],
//       date: dateTimestamp!,
//       // date: json['date'] is Timestamp
//       //     ? json['date']
//       //     : Timestamp.fromMillisecondsSinceEpoch(json["date"]),
//       id: json["id"],
//       fcmToken: json["fcmToken"],
//       image: json["image"],
//       joinDate: json["joinDate"],
//       lastMessageTime: json["lastMessageTime"],
//       status: json["status"],
//       role: json["role"],
//       team: json["team"],
//       teamId: json["teamId"],
//       type: json["type"],
//     );
//   }
//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "email": email,
//         "address": address,
//         "contact": contact,
//         "date": date,
//         "id": id,
//         "fcmToken": fcmToken,
//         "image": image,
//         "joinDate": joinDate,
//         "lastMessageTime": lastMessageTime,
//         "status": status,
//         "role": role,
//         "team": team,
//         "teamId": teamId,
//         "type": type,
//       };
// }
// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? name;
  String? email;
  String? image;
  Timestamp? date;
  String? id;
  String? fcmToken;

  UserModel({
    this.name,
    this.email,
    this.image,
    this.date,
    this.id,
    this.fcmToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        email: json["email"],
        image: json["image"],
        fcmToken: json["fcmToken"],
        date: json['date'] is Timestamp
            ? json['date']
            : Timestamp.fromMillisecondsSinceEpoch(json["date"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "image": image,
        "fcmToken": fcmToken,
        "date": date,
        "id": id,
      };
}
