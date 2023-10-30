import 'package:flutter/material.dart';
import 'package:get/get.dart';

BuildContext? snackContext;

void showErrorMsg(String msg, {BuildContext? context}) {
  Get.snackbar(
    "Error !!!",
    msg,
    duration: 10.seconds,
    backgroundColor: Colors.red,
    mainButton: TextButton(
      onPressed: Get.back,
      child: const Icon(
        Icons.close,
        color: Colors.white,
      ),
    ),
  );
}

void toastMsg(String msg) {
  Get.snackbar(
    "Success !!!",
    msg,
    duration: 5.seconds,
    backgroundColor: Colors.green,
    mainButton: TextButton(
      onPressed: Get.back,
      child: const Icon(
        Icons.close,
        color: Colors.white,
      ),
    ),
  );
}
