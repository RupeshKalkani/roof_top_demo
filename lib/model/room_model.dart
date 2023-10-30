import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

RoomModel? roomModelFromJson(String str) =>
    RoomModel.fromJson(json.decode(str));

String roomModelToJson(RoomModel? data) => json.encode(data!.toJson());

class RoomModel {
  RoomModel({
    this.uidList,
    this.newMsg,
    this.roomId,
    this.activeSpyId,
    this.lastMsgSender,
    this.lastMsgTime,
    this.tryCount,
    this.spyCrater,
  });

  List<String>? uidList;
  Map<String, int>? newMsg;
  String? roomId;
  String? activeSpyId;
  String? lastMsgSender;
  Timestamp? lastMsgTime;
  int? tryCount;
  String? spyCrater;

  RoomModel copyWith({
    List<String>? uidList,
    Map<String, int>? newMsg,
    String? roomId,
    String? activeSpyId,
    String? lastMsgSender,
    Timestamp? lastMsgTime,
    int? tryCount,
    String? spyCrater,
  }) =>
      RoomModel(
        uidList: uidList ?? this.uidList,
        newMsg: newMsg ?? this.newMsg,
        roomId: roomId ?? this.roomId,
        activeSpyId: activeSpyId ?? this.activeSpyId,
        lastMsgSender: lastMsgSender ?? this.lastMsgSender,
        lastMsgTime: lastMsgTime ?? this.lastMsgTime,
        tryCount: tryCount ?? this.tryCount,
        spyCrater: spyCrater ?? this.spyCrater,
      );

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
        uidList:
            json['uid_list'] is List ? json['uid_list'].cast<String>() : null,
        newMsg:
            json['new_msg'] is Map ? json['new_msg'].cast<String, int>() : null,
        roomId: json['room_id'],
        activeSpyId: json['active_spy_id'],
        lastMsgSender: json['last_msg_sender'],
        lastMsgTime: json['last_msg_time'],
        tryCount: json['try_count'],
        spyCrater: json['spy_crater'],
      );

  Map<String, dynamic> toJson() => {
        'uid_list': uidList,
        'new_msg': newMsg,
        'room_id': roomId,
        'active_spy_id': activeSpyId,
        'last_msg_sender': lastMsgSender,
        'last_msg_time': lastMsgTime,
        'try_count': tryCount,
        'spy_crater': spyCrater,
      };

  Map<String, dynamic> updateJson() {
    Map<String, dynamic> data = toJson();
    data.removeWhere((key, value) => value == null);
    return data;
  }
}
