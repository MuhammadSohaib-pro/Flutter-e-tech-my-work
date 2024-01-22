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
