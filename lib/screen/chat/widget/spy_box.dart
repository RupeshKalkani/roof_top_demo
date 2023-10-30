import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roof_top_demo/common_file/image_viewer.dart';
import 'package:roof_top_demo/common_file/methods.dart';
import 'package:roof_top_demo/common_file/sizer.dart';
import 'package:roof_top_demo/model/chat_model.dart';
import 'package:roof_top_demo/model/room_model.dart';
import 'package:roof_top_demo/screen/chat/chat_controller.dart';
import 'package:roof_top_demo/service/pref_service.dart';

class SpyBox extends StatelessWidget {
  final ChatModel? chatModel;
  final RoomModel? roomStream;
  final String? chatId;

  SpyBox({super.key, this.chatModel, this.roomStream, this.chatId});
  final ChatController controller = Get.put(ChatController(),permanent: true);

  @override
  Widget build(BuildContext context) {
    bool isSenderMe = chatModel?.senderId == PrefService.getUID();
    if (chatModel == null) {
      return const SizedBox();
    }
    return box();
  }

  Widget box() {
    bool isSenderMe = chatModel?.senderId == PrefService.getUID();
    return Column(
      crossAxisAlignment:
          isSenderMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => Get.to(() => ImgViewer(image: chatModel!.image)),
              child: Container(
                padding: EdgeInsets.all(1.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFA2221E),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(5 + 1.w),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    imageUrl: chatModel!.image.toString(),
                    height: 40.w,
                    progressIndicatorBuilder: (con, str, progress) {
                      return SizedBox(
                        height: 40.w,
                        width: 20.w,
                        child: Center(
                          child: CircularProgressIndicator(
                              value: progress.progress),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Visibility(
              visible: !isSenderMe && roomStream?.activeSpyId == chatId && roomStream?.lastMsgSender != PrefService.getUID(),
              child: IconButton(
                onPressed: () => controller.onSpyEditTap(chatModel!),
                icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white),
                  ),
                  padding: EdgeInsets.all(1.5.w),
                  child: Icon(Icons.edit),
                ),
              ),
            ),
          ],
        ),
        Visibility(
          visible: (chatModel?.msg ?? '').isNotEmpty,
          child: Padding(
            padding: EdgeInsets.only(top: 1.w),
            child: Container(
              constraints: BoxConstraints(
                minWidth: 10.w,
                maxWidth: 40.w,
              ),
              padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 1.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xFFA2221E),
              ),
              child: Text(
                chatModel!.msg.toString(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
