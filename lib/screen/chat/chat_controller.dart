import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_editor_plus/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roof_top_demo/common_file/helpers.dart';
import 'package:roof_top_demo/common_file/methods.dart';
import 'package:roof_top_demo/model/chat_model.dart';
import 'package:roof_top_demo/model/room_model.dart';
import 'package:roof_top_demo/model/user_model.dart';
import 'package:roof_top_demo/screen/chat/widget/create_spy_dialog.dart';
import 'package:roof_top_demo/screen/chat/widget/send_edited_spy.dart';
import 'package:roof_top_demo/service/chat_service.dart';
import 'package:roof_top_demo/service/pref_service.dart';
import 'package:roof_top_demo/service/storage_service.dart';
import 'package:roof_top_demo/service/user_service.dart';
import 'package:roof_top_demo/utils/pref_keys.dart';

class ChatController extends GetxController {
  final TextEditingController msgController = TextEditingController();
  File? pickedImg;
  String pickedFileError = "";
  UserModel receiverModel = UserModel();
  bool loader = false;
  RoomModel roomModel = RoomModel();
  final TextEditingController characterController = TextEditingController();
  String characterError = "";

  Future<void> init({UserModel? userModel}) async {
    loader = false;
    receiverModel = userModel ?? receiverModel;
    await getRoomDetail();
  }

  Future<void> getRoomDetail() async {
    final model = await ChatService.getRoomData(receiverModel.uid.toString());
    roomModel = model ?? roomModel;
    roomModel.roomId =
        roomModel.roomId ?? getRoomId(PrefService.getUID(), receiverModel.uid);
    update(['loader']);
  }

  bool showSpyCreateBox() {
    return roomModel.spyCrater.toString() == "null";
  }

  void onSendSpyTap() {
    Get.dialog(
      Dialog(
        child: CreateSpyDialog(),
      ),
    );
  }

  Future<void> onSpyImgSelectionTap() async {
    try {
      final xFile = await ImagePicker().pickImage(source: ImageSource.camera);
      if (xFile != null) {
        pickedImg = File(xFile.path);
      }
      update(['loader']);
    } catch (e) {
      showErrorMsg(e.toString());
    }
  }

  Future<void> onSpyCreteSubmitTap() async {
    if (createSpyValidation()) {
      Get.back();
      loader = true;
      update(['loader']);

      final createAt = Timestamp.now();
      String spyId = DateTime.now().millisecondsSinceEpoch.toString();
      final imgUrl = await StorageService.storeImage(
          pickedImg!, roomModel.roomId.toString());
      final ChatModel chatModel = ChatModel(
        image: imgUrl,
        type: "spy",
        msg: characterController.text,
        createDate: createAt,
        senderId: PrefService.getUID(),
      );
      await ChatService.addNewMsg(chatModel, roomModel.roomId.toString(),
          docId: spyId);

      final RoomModel roomData = RoomModel(
        lastMsgTime: createAt,
        activeSpyId: spyId,
        newMsg: roomModel.newMsg ??
            {receiverModel.uid.toString(): 1, PrefService.getUID(): 0},
        roomId: roomModel.roomId.toString(),
        spyCrater: PrefService.getUID(),
        tryCount: 0,
        lastMsgSender: PrefService.getUID(),
        uidList: [
          receiverModel.uid.toString(),
          PrefService.getUID(),
        ],
      );
      roomModel = roomData;
      await ChatService.putRoomData(
        roomData,
        receiverModel.uid.toString(),
      );
      pickedImg = null;
      characterController.clear();
      loader = false;
      update(['loader']);
    }
  }

  bool createSpyValidation() {
    if (pickedImg == null) {
      pickedFileError = "*Image is Required";
    } else {
      pickedFileError = "";
    }

    if (characterController.text.trim().isEmpty) {
      characterError = "*Character is Required";
    } else {
      characterError = "";
    }

    update(['loader']);

    return (pickedFileError.isEmpty && characterError.isEmpty);
  }

  Future<void> onSpyEditTap(ChatModel chatModel) async {
    loader = true;
    update(['loader']);
    try {
      final bytes = await getByteFromNetworkImg(chatModel.image.toString());
      final result = await Get.to(() => ImageEditor(
            image: bytes,
          ));

      if (result is Uint8List) {
        final file = await getFileFromUint8List(result);
        if (file != null) {
          Get.dialog(
            Dialog(
              child: SendEditedSpy(spyImg: file),
            ),
          );
        }
      }
    } catch (e) {
      showErrorMsg(e.toString());
    }
    loader = false;
    update(['loader']);
  }

  Future<void> sendEditedSpy(File? file) async {
    Get.back();
    loader = true;
    update(['loader']);

    final createAt = Timestamp.now();
    final imgUrl =
        await StorageService.storeImage(file!, roomModel.roomId.toString());
    final ChatModel chatModel = ChatModel(
      image: imgUrl,
      type: "image",
      createDate: createAt,
      senderId: PrefService.getUID(),
    );
    await ChatService.addNewMsg(chatModel, roomModel.roomId.toString());
    RoomModel tempRoomModel = roomModel;

    tempRoomModel.lastMsgTime = createAt;
    tempRoomModel.tryCount = (roomModel.tryCount ?? 0) + 1;
    tempRoomModel.lastMsgSender = PrefService.getUID();

    tempRoomModel.newMsg?[receiverModel.uid.toString()] =
        (tempRoomModel.newMsg?[receiverModel.uid] ?? 0) + 1;

    await ChatService.updateRoomData(
      tempRoomModel,
      receiverModel.uid.toString(),
    );
    loader = false;
    update(['loader']);
  }

  Future<void> onRightAnswerTap() async {
    loader = true;
    update(['loader']);

    await sendReview(true);

    loader = false;
    update(['loader']);
  }

  Future<void> onWrongAnswerTap() async {
    loader = true;
    update(['loader']);

    await sendReview(false);

    loader = false;
    update(['loader']);
  }

  Future<void> sendReview(bool result) async {
    final createAt = Timestamp.now();
    final ChatModel chatModel = ChatModel(
      type: "review",
      msg: result.toString(),
      createDate: createAt,
      senderId: PrefService.getUID(),
    );
    await ChatService.addNewMsg(chatModel, roomModel.roomId.toString());

    RoomModel tempRoomModel = roomModel;
    tempRoomModel.lastMsgTime = createAt;
    tempRoomModel.lastMsgSender = PrefService.getUID();

    if (result || tempRoomModel.tryCount == 3) {
      tempRoomModel.spyCrater = "null";
      tempRoomModel.activeSpyId = "null";
      final ChatModel alertModel = ChatModel(
        type: "result",
        msg: result.toString(),
        createDate: Timestamp.now(),
        senderId: PrefService.getUID(),
      );
      await ChatService.addNewMsg(alertModel, tempRoomModel.roomId.toString());

      if (result) {
        receiverModel.totalPoint = (receiverModel.totalPoint ?? 0) + 1;
        await UserService.updateUserData(receiverModel);
      }
    }

    tempRoomModel.newMsg?[receiverModel.uid.toString()] =
        (tempRoomModel.newMsg?[receiverModel.uid] ?? 0) + 1;

    await ChatService.updateRoomData(
      tempRoomModel,
      receiverModel.uid.toString(),
    );
  }

  /*Future<void> setMsgStatusRead() async {
    if(roomModel.lastMsgSender == null){
      return;
    }
    RoomModel tempRoomModel = roomModel;
    tempRoomModel.newMsg?[getUID()] = 0;

    await ChatService.updateRoomData(
      tempRoomModel,
      receiverModel.uid.toString(),
    );
  }*/
}
