import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roof_top_demo/common_file/buttons.dart';
import 'package:roof_top_demo/common_file/common_textfield.dart';
import 'package:roof_top_demo/common_file/common_widget.dart';
import 'package:roof_top_demo/common_file/image_viewer.dart';
import 'package:roof_top_demo/common_file/sizer.dart';
import 'package:roof_top_demo/common_file/style.dart';
import 'package:roof_top_demo/screen/chat/chat_controller.dart';

class SendEditedSpy extends StatelessWidget {
  final File? spyImg;

  SendEditedSpy({super.key, this.spyImg});

  final ChatController controller = Get.put(ChatController(),permanent: true);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      id: 'loader',
      builder: (con) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Submit Guessed Object",
                style: styleW500S18,
              ),
              SizedBox(height: 2.w),
              InkWell(
                onTap: () => Get.to(
                  () => ImgViewer(image: spyImg?.path, isFileImg: true),
                ),
                child: spyImg == null
                    ? const SizedBox()
                    : Image.file(spyImg!),
              ),
              SizedBox(height: 2.w),
              SubmitButton(
                title: "Submit",
                onTap: () => controller.sendEditedSpy(spyImg),
              ),
            ],
          ),
        );
      },
    );
  }
}
