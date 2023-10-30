import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roof_top_demo/common_file/sizer.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? const CupertinoActivityIndicator()
        : const CircularProgressIndicator();
  }
}

class SmallLoader extends StatelessWidget {
  const SmallLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: AppLoader(),
    );
  }
}

class StackedLoader extends StatelessWidget {
  final Widget? child;
  final bool? loading;

  const StackedLoader({Key? key, this.child, this.loading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child ?? const SizedBox(),
        if (loading == true)
          Container(
            color: Colors.white.withOpacity(0.1),
            height: Get.height,
            width: Get.width,
            child: const Center(
              child: AppLoader(),
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }
}

bool isLoaderDialogOpen = false;
void startLoaderDialog() {
  if (isLoaderDialogOpen) {
    return;
  }
  isLoaderDialogOpen = true;
  Get.dialog(
    Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: SizedBox(
        height: 100.h,
        width: 100.w,
        child: const SmallLoader(),
      ),
    ),
    useSafeArea: false,
    barrierDismissible: false,
    barrierColor: Colors.white.withOpacity(0.1),
  ).whenComplete(() {
    isLoaderDialogOpen = false;
  });
}

void closeLoaderDialog() {
  if (isLoaderDialogOpen) {
    Get.back();
  }
}
