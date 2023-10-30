import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ChatModel? chatModelFromJson(String str) =>
    ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel? data) => json.encode(data!.toJson());

class ChatModel {
  ChatModel({
    this.image,
    this.msg,
    this.senderId,
    this.type,
    this.createDate,
  });

  String? image;
  String? msg;
  String? senderId;
  String? type;
  Timestamp? createDate;

  ChatModel copyWith({
    String? image,
    String? msg,
    String? senderId,
    String? type,
    Timestamp? createDate,
  }) =>
      ChatModel(
        image: image ?? this.image,
        msg: msg ?? this.msg,
        senderId: senderId ?? this.senderId,
        type: type ?? this.type,
        createDate: createDate ?? this.createDate,
      );

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        image: json['image'],
        msg: json['msg'],
        senderId: json['sender_id'],
        type: json['type'],
        createDate: json['create_date'],
      );

  Map<String, dynamic> toJson() => {
        'image': image,
        'msg': msg,
        'sender_id': senderId,
        'type': type,
        'create_date': createDate,
      };

  Map<String, dynamic> updateJson() {
    Map<String, dynamic> data = toJson();
    data.removeWhere((key, value) => value == null);
    return data;
  }
}
