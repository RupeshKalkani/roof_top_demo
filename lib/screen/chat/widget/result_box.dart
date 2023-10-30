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

class ResultBox extends StatelessWidget {
  final ChatModel? chatModel;

  ResultBox({super.key, this.chatModel});

  final ChatController controller = Get.put(ChatController(),permanent: true);

  @override
  Widget build(BuildContext context) {
    return box();
  }

  Widget box() {
    bool isSenderMe = chatModel?.senderId == PrefService.getUID();
    String msg = "";
    if (chatModel?.msg == "true") {
      msg =
          "${!isSenderMe ? "You" : controller.receiverModel.name ?? ''} win the Game, you earned 1 point.";
    } else {
      msg =
          "${!isSenderMe ? "You" : controller.receiverModel.name ?? ''} loss the Game.";
    }
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(vertical: 2.w),
      child: Center(
        child: Text(
          msg,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
