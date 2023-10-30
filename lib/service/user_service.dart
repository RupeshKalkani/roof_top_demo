import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roof_top_demo/common_file/helpers.dart';
import 'package:roof_top_demo/common_file/methods.dart';
import 'package:roof_top_demo/model/user_model.dart';
import 'package:roof_top_demo/service/pref_service.dart';
import 'package:roof_top_demo/utils/firebase_keys.dart';
import 'package:roof_top_demo/utils/pref_keys.dart';

class UserService {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  static Future<void> postUserData(UserModel userModel) async {
    try {
      await _instance
          .collection(FirebaseKeys.users)
          .doc(userModel.uid)
          .set(userModel.toJson());
    } on FirebaseException catch (e) {
      showErrorMsg(e.message.toString());
    } catch (e) {
      showErrorMsg(e.toString());
    }
  }

  static Future<void> updateUserData(UserModel userModel) async {
    try {
      await _instance
          .collection(FirebaseKeys.users)
          .doc(userModel.uid)
          .update(userModel.updateJson());
    } on FirebaseException catch (e) {
      showErrorMsg(e.message.toString());
    } catch (e) {
      showErrorMsg(e.toString());
    }
  }

  static Future<UserModel?> getUserModel(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _instance.collection(FirebaseKeys.users).doc(uid).get();

      if (snapshot.data() != null) {
        return UserModel.fromJson(snapshot.data()!);
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      showErrorMsg(e.message.toString());
    } catch (e) {
      showErrorMsg(e.toString());
    }
    return null;
  }

  static Future<void> deleteUser(String uid) async {
    try {
      await _instance.collection(FirebaseKeys.users).doc(uid).delete();
    } on FirebaseException catch (e) {
      showErrorMsg(e.message.toString());
    } catch (e) {
      showErrorMsg(e.toString());
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getOnlineUserList() {
    return _instance
        .collection(FirebaseKeys.users)
        .where(
          "is_online",
          isEqualTo: true,
        )
        .where(
          "uid",
          isNotEqualTo: PrefService.getUID(),
        )
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getMatchesUserList() {
    return _instance
        .collection(FirebaseKeys.chat)
        .where(
          "uid_list",
          arrayContainsAny: [PrefService.getUID()],
        ).orderBy('last_msg_time',descending: true)
        .snapshots();
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUsersStream(String uid) {
    return _instance
        .collection(FirebaseKeys.users)
        .doc(uid.toString())
        .snapshots();
  }
}
