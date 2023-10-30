import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roof_top_demo/common_file/sizer.dart';
import 'package:roof_top_demo/screen/chat/chat_controller.dart';
import 'package:roof_top_demo/utils/asset_res.dart';

class RightWrongBtn extends StatelessWidget {
  RightWrongBtn({super.key});

  final ChatController controller = Get.put(ChatController(),permanent: true);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 5.w),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: controller.onRightAnswerTap,
              child: Image.asset(
                AssetRes.rightImg,
                height: 15.w,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: controller.onWrongAnswerTap,
              child: Image.asset(
                AssetRes.wrongImg,
                height: 15.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
