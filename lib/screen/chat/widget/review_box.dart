import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roof_top_demo/common_file/image_viewer.dart';
import 'package:roof_top_demo/common_file/methods.dart';
import 'package:roof_top_demo/common_file/sizer.dart';
import 'package:roof_top_demo/model/chat_model.dart';
import 'package:roof_top_demo/screen/chat/chat_controller.dart';
import 'package:roof_top_demo/service/pref_service.dart';
import 'package:roof_top_demo/utils/asset_res.dart';

class ReviewBox extends StatelessWidget {
  final ChatModel? chatModel;

  ReviewBox({super.key, this.chatModel});

  final ChatController controller = Get.put(ChatController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return box();
  }

  Widget box() {
    bool isSenderMe = chatModel?.senderId == PrefService.getUID();
    return Column(
      crossAxisAlignment:
          isSenderMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: (chatModel?.msg ?? '').isNotEmpty,
          child: Padding(
            padding: EdgeInsets.only(top: 1.w),
            child: chatModel?.msg == "true"
                ? Image.asset(
                    AssetRes.rightImg,
                    height: 10.w,
                  )
                : Image.asset(
                    AssetRes.wrongImg,
                    height: 10.w,
                  ),
          ),
        ),
      ],
    );
  }
}
