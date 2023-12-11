import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roof_top_demo/screen/home/home_controller.dart';
import 'package:roof_top_demo/screen/home/home_screen.dart';
import 'package:roof_top_demo/screen/register/register_controller.dart';
import 'package:roof_top_demo/screen/register/register_screen.dart';
import 'package:roof_top_demo/service/auth_service.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String emailError = "";
  String passwordError = "";
  bool loader = false;
  bool hidePassword = true;

  void onPwdVisibilityChange() {
    hidePassword = !hidePassword;
    update(['loader']);
  }

  Future<void> onLoginTap() async {
    if (validation()) {
      loader = true;
      update(['loader']);
      bool result = await AuthService.loginWithCredential(
        email: emailController.text,
        pwd: passwordController.text,
      );
      if (result) {
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

  void onRegisterTap() {
    RegisterController controller =
        Get.put(RegisterController(), permanent: true);
    Get.to(
      () => RegisterScreen(),
      duration: 1.5.seconds,
      curve: Curves.ease,
    );
  }

  bool validation() {
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
      passwordError = "*Password is require";
    } else if (passwordController.text.length < 6) {
      passwordError = "*Minimum 6 character is require";
    } else {
      passwordError = "";
    }

    update(['loader']);
    return (emailError.isEmpty && passwordError.isEmpty);
  }
}
