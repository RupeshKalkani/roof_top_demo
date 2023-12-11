import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roof_top_demo/model/user_model.dart';
import 'package:roof_top_demo/screen/home/home_controller.dart';
import 'package:roof_top_demo/screen/home/home_screen.dart';
import 'package:roof_top_demo/screen/login/login_controller.dart';
import 'package:roof_top_demo/screen/login/login_screen.dart';
import 'package:roof_top_demo/service/auth_service.dart';
import 'package:roof_top_demo/service/pref_service.dart';
import 'package:roof_top_demo/service/user_service.dart';
import 'package:roof_top_demo/utils/pref_keys.dart';

class RegisterController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwdController = TextEditingController();
  String nameError = "";
  String emailError = "";
  String passwordError = "";
  String confirmPwdError = "";
  bool loader = false;
  bool hidePassword = true;
  bool hideConfirmPwd = true;
  bool fromSettingScreen = false;

  void onPwdVisibilityChange() {
    hidePassword = !hidePassword;
    update(['loader']);
  }

  void onConfirmPwdVisibilityChange() {
    hideConfirmPwd = !hideConfirmPwd;
    update(['loader']);
  }

  Future<void> onRegisterTap() async {
    if (validation()) {
      loader = true;
      update(['loader']);
      String? uid = await AuthService.signupWithCredential(
        email: emailController.text,
        pwd: passwordController.text,
      );

      if (uid != null) {
        await PrefService.set(PrefKeys.userUID, uid.toString());
        await UserService.postUserData(
          UserModel(
            name: nameController.text,
            createDate: Timestamp.now(),
            email: emailController.text,
            uid: uid,
            isOnline: true,
            totalPoint: 0,
          ),
        );
        LoginController loginController =
            Get.put(LoginController(), permanent: true);
        HomeController controller = Get.put(HomeController(), permanent: true);
        controller.init();
        Get.offAll(
          () => HomeScreen(),
          duration: 1.5.seconds,
          curve: Curves.ease,
        );
      }
      loader = false;
      update(['loader']);
    }
  }

  void onLoginTap() {
    if (fromSettingScreen) {
      Get.to(
        () => LoginScreen(),
        duration: 1.5.seconds,
        curve: Curves.ease,
      );
    } else {
      Get.back();
    }
  }

  bool validation() {
    /// Name Validation
    if (nameController.text.trim().isEmpty) {
      nameError = "*Name is require".tr;
    } else {
      nameError = "";
    }

    /// Email Validation
    if (emailController.text.trim().isEmpty) {
      emailError = "*Email is require".tr;
    } else if (!GetUtils.isEmail(emailController.text.trim())) {
      emailError = "*Enter valid Email Address".tr;
    } else {
      emailError = "";
    }

    /// Password Validation
    if (passwordController.text.trim().isEmpty) {
      passwordError = "*Password is require".tr;
    } else if (passwordController.text.length < 6) {
      passwordError = "*Minimum 6 character is require".tr;
    } else {
      passwordError = "";
    }

    /// Confirm Password Validation
    if (confirmPwdController.text.trim().isEmpty) {
      confirmPwdError = "*Confirm password is require".tr;
    } else if (confirmPwdController.text.length < 6) {
      confirmPwdError = "*Minimum 6 character is require".tr;
    } else if (confirmPwdController.text != passwordController.text) {
      confirmPwdError = "*Confirm password mismatch".tr;
    } else {
      confirmPwdError = "";
    }

    update(['loader']);
    return (confirmPwdError.isEmpty &&
        emailError.isEmpty &&
        passwordError.isEmpty);
  }
}
