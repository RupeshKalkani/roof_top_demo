import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roof_top_demo/common_file/buttons.dart';
import 'package:roof_top_demo/common_file/common_textfield.dart';
import 'package:roof_top_demo/common_file/common_widget.dart';
import 'package:roof_top_demo/common_file/sizer.dart';
import 'package:roof_top_demo/common_file/style.dart';
import 'package:roof_top_demo/screen/chat/chat_controller.dart';

class CreateSpyBox extends StatelessWidget {
  CreateSpyBox({super.key});

  final ChatController controller = Get.put(ChatController(),permanent: true);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 2.w),
      child: InkWell(
        onTap: controller.onSendSpyTap,
        child: Container(
          height: 20.h,
          width: 100.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: const Center(
            child: Icon(
              Icons.camera_alt_outlined,
              size: 70,
            ),
          ),
        ),
      ),
    );
  }
}

class CreateSpyDialog extends StatelessWidget {
  CreateSpyDialog({super.key});

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
                "Create Spy",
                style: styleW500S18,
              ),
              SizedBox(height: 2.w),
              InkWell(
                onTap: controller.onSpyImgSelectionTap,
                child: Container(
                  height: 20.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: (controller.pickedFileError).isEmpty
                            ? Colors.white
                            : Colors.red,
                        width: 2),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: controller.pickedImg != null
                      ? Image.file(controller.pickedImg!)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.camera_alt_outlined,
                              size: 70,
                            ),
                            SizedBox(height: 1.w),
                            Text("Capture Image", style: styleW400S16),
                          ],
                        ),
                ),
              ),
              (controller.pickedFileError).isEmpty
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ErrorText(text: controller.pickedFileError),
                      ],
                    ),
              SizedBox(height: 2.w),
              Text(
                "Enter Character",
                style: styleW500S18,
              ),
              SizedBox(height: 2.w),
              AppTextField(
                controller: controller.characterController,
                errorText: controller.characterError,
                hintText: 'Please Enter Your Character',
              ),
              SizedBox(height: 4.w),
              SubmitButton(
                title: "Submit",
                onTap: controller.onSpyCreteSubmitTap,
              ),
            ],
          ),
        );
      },
    );
  }
}
