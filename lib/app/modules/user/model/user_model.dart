// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? fullName;
  String? email;
  DateTime? createdDate;

  UserModel({this.id, this.fullName, this.email, this.createdDate});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["_id"],
    fullName: json["fullName"],
    email: json["email"],
    createdDate: json["createdDate"] == null
        ? null
        : DateTime.parse(json["createdDate"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "email": email,
    "createdDate": createdDate?.toIso8601String(),
  };
}
