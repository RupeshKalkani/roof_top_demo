import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:roof_top_demo/common_file/helpers.dart';
import 'package:roof_top_demo/common_file/methods.dart';
import 'package:roof_top_demo/model/chat_model.dart';
import 'package:roof_top_demo/model/room_model.dart';
import 'package:roof_top_demo/model/user_model.dart';
import 'package:roof_top_demo/service/pref_service.dart';
import 'package:roof_top_demo/utils/firebase_keys.dart';
import 'package:roof_top_demo/utils/pref_keys.dart';

class StorageService {
  static final FirebaseStorage _instance = FirebaseStorage.instance;

  static Future<String?> storeImage(File file, String roomId) async {
    try {
      final ref = _instance
          .ref()
          .child(FirebaseKeys.chatImage)
          .child(roomId)
          .child(DateTime.now().millisecondsSinceEpoch.toString());
      final task = await ref.putFile(file);
      final downloadUrl = await task.ref.getDownloadURL();
      print(task.metadata?.fullPath);
      return downloadUrl;
    } on FirebaseException catch (e) {
      showErrorMsg(e.message.toString());
    } catch (e) {
      showErrorMsg(e.toString());
    }
    return null;
  }
}
