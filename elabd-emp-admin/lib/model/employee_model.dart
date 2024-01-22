// To parse this JSON data, do
//
//     final employeeModel = employeeModelFromJson(jsonString);


import 'dart:convert';



EmployeeModel employeeModelFromJson(String str) => EmployeeModel.fromJson(json.decode(str));
String employeeModelToJson(EmployeeModel data) => json.encode(data.toJson());

class EmployeeModel {
    final String? name;
    final String? email;
    final String? address;
    final String? contact;
    final String? image;
    final String? joinDate;
    final String? password;
    final String? team;

    EmployeeModel({
        this.name,
        this.email,
        this.address,
        this.contact,
        this.image,
        this.joinDate,
        this.password,
        this.team,
    });

    factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        name: json["name"],
        email: json["email"],
        address: json["address"],
        contact: json["contact"],
        image: json["image"],
        joinDate: json["joinDate"],
        password: json["password"],
        team: json["team"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "address": address,
        "contact": contact,
        "image": image,
        "joinDate": joinDate,
        "password": password,
        "team": team,
    };
}
