import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roof_top_demo/common_file/helpers.dart';
import 'package:roof_top_demo/common_file/methods.dart';
import 'package:roof_top_demo/model/chat_model.dart';
import 'package:roof_top_demo/model/room_model.dart';
import 'package:roof_top_demo/model/user_model.dart';
import 'package:roof_top_demo/service/pref_service.dart';
import 'package:roof_top_demo/utils/firebase_keys.dart';
import 'package:roof_top_demo/utils/pref_keys.dart';

class ChatService {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserChat(String uid) {
    return _instance
        .collection(FirebaseKeys.chat)
        .doc(getRoomId(PrefService.getUID(), uid))
        .collection(FirebaseKeys.chat)
        .orderBy('create_date', descending: true)
        .snapshots();
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getRoomStream(
      String uid) {
    return _instance
        .collection(FirebaseKeys.chat)
        .doc(getRoomId(PrefService.getUID(), uid))
        .snapshots();
  }

  static Future<RoomModel?> getRoomData(String uid) async {
    try {
      final data = await _instance
          .collection(FirebaseKeys.chat)
          .doc(getRoomId(PrefService.getUID(), uid))
          .get();

      if (data.data() != null) {
        return RoomModel.fromJson(data.data()!);
      }
    } on FirebaseException catch (e) {
      showErrorMsg(e.message.toString());
    } catch (e) {
      showErrorMsg(e.toString());
    }
    return null;
  }

  static Future<void> addNewMsg(ChatModel chatModel, roomId,
      {String? docId}) async {
    try {
      if (docId != null) {
        await _instance
            .collection(FirebaseKeys.chat)
            .doc(roomId)
            .collection(FirebaseKeys.chat)
            .doc(docId)
            .set(chatModel.toJson());
      } else {
        await _instance
            .collection(FirebaseKeys.chat)
            .doc(roomId)
            .collection(FirebaseKeys.chat)
            .add(chatModel.toJson());
      }
    } on FirebaseException catch (e) {
      showErrorMsg(e.message.toString());
    } catch (e) {
      showErrorMsg(e.toString());
    }
  }

  static Future<void> putRoomData(RoomModel roomModel, receiverUID) async {
    try {
      await _instance
          .collection(FirebaseKeys.chat)
          .doc(getRoomId(PrefService.getUID(), receiverUID))
          .set(roomModel.updateJson());
    } on FirebaseException catch (e) {
      showErrorMsg(e.message.toString());
    } catch (e) {
      showErrorMsg(e.toString());
    }
  }

  static Future<void> updateRoomData(RoomModel roomModel, receiverUID) async {
    try {
      await _instance
          .collection(FirebaseKeys.chat)
          .doc(getRoomId(PrefService.getUID(), receiverUID))
          .update(roomModel.updateJson());
    } on FirebaseException catch (e) {
      showErrorMsg(e.message.toString());
    } catch (e) {
      showErrorMsg(e.toString());
    }
  }
}
