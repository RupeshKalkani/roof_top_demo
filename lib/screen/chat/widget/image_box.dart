import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roof_top_demo/common_file/image_viewer.dart';
import 'package:roof_top_demo/common_file/methods.dart';
import 'package:roof_top_demo/common_file/sizer.dart';
import 'package:roof_top_demo/model/chat_model.dart';
import 'package:roof_top_demo/service/pref_service.dart';

class ImageBox extends StatelessWidget {
  final ChatModel? chatModel;

  const ImageBox({super.key, this.chatModel});

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
    return Row(
      mainAxisAlignment:
          isSenderMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment:
              isSenderMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Get.to(() => ImgViewer(image: chatModel!.image)),
              child: CachedNetworkImage(
                imageUrl: chatModel!.image.toString(),
                height: 35.w,

                progressIndicatorBuilder: (con, str, progress) {
                  return Container(
                    height: 35.w,
                    width: 20.w,
                    color: Colors.black,
                    child: Center(
                      child:
                          CircularProgressIndicator(value: progress.progress),
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: (chatModel?.msg ?? '').isNotEmpty,
              child: Padding(
                padding: EdgeInsets.only(top: 1.w),
                child: Text(
                  chatModel!.msg.toString(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
