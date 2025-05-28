import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roof_top_demo/screen/home/home_controller.dart';
import 'package:roof_top_demo/screen/home/home_screen.dart';
import 'package:roof_top_demo/screen/login/login_controller.dart';
import 'package:roof_top_demo/screen/login/login_screen.dart';
import 'package:roof_top_demo/service/pref_service.dart';
import 'package:roof_top_demo/utils/pref_keys.dart';

class SplashController extends GetxController {
  bool isPageNavigate = false;
  final Duration splashDuration = 3.seconds;

  @override
  void onInit() {
    startActivity();
    super.onInit();
  }

  Future<void> startActivity() async {
    Future.delayed(splashDuration, () {
      if (PrefService.getBool(PrefKeys.isLogin)) {
        Get.offAll(() => const HomeScreen());
      } else {
        Get.offAll(() => LoginScreen());
      }
    });
  }
}
