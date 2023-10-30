

import 'package:firebase_auth/firebase_auth.dart';
import 'package:roof_top_demo/common_file/helpers.dart';
import 'package:roof_top_demo/service/pref_service.dart';
import 'package:roof_top_demo/utils/pref_keys.dart';

class AuthService {
  static final FirebaseAuth _instance = FirebaseAuth.instance;

  static Future<bool> logoutUser() async {
    try {
      await PrefService.set(PrefKeys.userUID, "");
      await _instance.signOut();
      return true;
    } on FirebaseException catch (e) {
      showErrorMsg(e.message.toString());
      return false;
    } catch (e) {
      showErrorMsg(e.toString());
      return false;
    }
  }

  static Future<bool> changeEmail({String? email, String? password}) async {
    try {
      User? user = _instance.currentUser;

      if (user == null) {
        return false;
      }
      if (email != null) {
        await user.updateEmail(email);
      }
      if (password != null) {
        await user.updatePassword(password);
      }
      return true;
    } on FirebaseException catch (e) {
      showErrorMsg(e.message.toString());
      return false;
    } catch (e) {
      showErrorMsg(e.toString());
      return false;
    }
  }

  static bool isLogin() {
    try {
      return (_instance.currentUser != null);
    } on FirebaseException catch (e) {
      if (e.code == "wrong-password") {
        showErrorMsg("Invalid email or password. Please try again");
      } else {
        showErrorMsg(e.message.toString());
      }
      return false;
    } catch (e) {
      showErrorMsg(e.toString());
      return false;
    }
  }

  static Future<bool> loginWithGuest() async {
    try {
      UserCredential user = await _instance.signInAnonymously();
      return (user.user != null);
    } on FirebaseException catch (e) {
      if (e.code == "wrong-password") {
        showErrorMsg("Invalid email or password. Please try again");
      } else {
        showErrorMsg(e.message.toString());
      }
      return false;
    } catch (e) {
      showErrorMsg(e.toString());
      return false;
    }
  }

  static Future<bool> loginWithCredential({
    required String email,
    required String pwd,
  }) async {
    try {
      UserCredential user = await _instance.signInWithEmailAndPassword(
        email: email,
        password: pwd,
      );
      if (user.user != null) {
        await PrefService.set(PrefKeys.userUID, user.user!.uid);
      }
      return (user.user != null);
    } on FirebaseException catch (e) {
      if (e.code == "wrong-password") {
        showErrorMsg("Invalid email or password. Please try again");
      } else {
        showErrorMsg(e.message.toString());
      }
      return false;
    } catch (e) {
      showErrorMsg(e.toString());
      return false;
    }
  }

  static Future<String?> signupWithCredential({
    required String email,
    required String pwd,
  }) async {
    try {
      UserCredential user = await _instance.createUserWithEmailAndPassword(
        email: email,
        password: pwd,
      );
      if (user.user != null) {
        await PrefService.set(PrefKeys.userUID, user.user!.uid);
        return user.user?.uid;
      }
      return null;
    } on FirebaseException catch (e) {
      showErrorMsg(e.message.toString());
      return null;
    } catch (e) {
      showErrorMsg(e.toString());
      return null;
    }
  }
}
