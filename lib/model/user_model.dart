import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel? userModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel? data) => json.encode(data!.toJson());

class UserModel {
  UserModel({
    this.name,
    this.uid,
    this.email,
    this.createDate,
    this.isOnline,
    this.totalPoint,
  });

  String? name;
  String? uid;
  String? email;
  Timestamp? createDate;
  bool? isOnline;
  int? totalPoint;

  UserModel copyWith({
    String? name,
    String? uid,
    String? email,
    Timestamp? createDate,
    bool? isOnline,
    int? totalPoint,
  }) =>
      UserModel(
        name: name ?? this.name,
        uid: uid ?? this.uid,
        email: email ?? this.email,
        createDate: createDate ?? this.createDate,
        isOnline: isOnline ?? this.isOnline,
        totalPoint: totalPoint ?? this.totalPoint,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        uid: json["uid"],
        email: json["email"],
        createDate: json["create_date"],
        isOnline: json['is_online'],
        totalPoint: json['total_point'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "email": email,
        "create_date": createDate,
        "is_online": isOnline,
        "total_point": totalPoint,
      };

  Map<String, dynamic> updateJson() {
    Map<String, dynamic> data = toJson();
    data.removeWhere((key, value) => value == null);
    return data;
  }
}
