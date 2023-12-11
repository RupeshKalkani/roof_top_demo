import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roof_top_demo/common_file/loaders.dart';
import 'package:roof_top_demo/common_file/methods.dart';
import 'package:roof_top_demo/common_file/sizer.dart';
import 'package:roof_top_demo/model/chat_model.dart';
import 'package:roof_top_demo/model/room_model.dart';
import 'package:roof_top_demo/screen/chat/chat_controller.dart';
import 'package:roof_top_demo/screen/chat/widget/create_spy_dialog.dart';
import 'package:roof_top_demo/screen/chat/widget/image_box.dart';
import 'package:roof_top_demo/screen/chat/widget/result_box.dart';
import 'package:roof_top_demo/screen/chat/widget/review_box.dart';
import 'package:roof_top_demo/screen/chat/widget/right_wrong_btn.dart';
import 'package:roof_top_demo/screen/chat/widget/spy_box.dart';
import 'package:roof_top_demo/service/chat_service.dart';
import 'package:roof_top_demo/service/pref_service.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final ChatController controller = Get.put(ChatController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.withOpacity(0.3),
      appBar: AppBar(
        title: Text(controller.receiverModel.name ?? ''),
      ),
      body: SafeArea(
        child: GetBuilder<ChatController>(
          id: 'loader',
          builder: (con) {
            return StackedLoader(
              loading: controller.loader,
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: ChatService.getRoomStream(
                    controller.receiverModel.uid.toString()),
                builder: (context, roomSnap) {
                  if (roomSnap.data == null) {
                    return const SizedBox();
                  }

                  RoomModel roomModel = RoomModel();
                  if (roomSnap.data?.data() != null) {
                    roomModel = RoomModel.fromJson(roomSnap.data!.data()!);
                    controller.roomModel = roomModel;
                  }
                  return Column(
                    children: [
                      Expanded(
                        child:
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: ChatService.getUserChat(
                              controller.receiverModel.uid.toString()),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return const SmallLoader();
                            }
                            // controller.setMsgStatusRead();
                            List<ChatModel> chatList = snapshot.data!.docs
                                .map((e) => ChatModel.fromJson(e.data()))
                                .toList();
                            return ListView.separated(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.2.w, vertical: 2.h),
                              separatorBuilder: (con, index) {
                                return SizedBox(height: 5.w);
                              },
                              itemCount: chatList.length,
                              reverse: true,
                              itemBuilder: (con, index) {
                                if (chatList[index].type == 'spy') {
                                  return SpyBox(
                                    chatModel: chatList[index],
                                    roomStream: roomModel,
                                    chatId: snapshot.data!.docs[index].id,
                                  );
                                } else if (chatList[index].type == 'image') {
                                  return ImageBox(chatModel: chatList[index]);
                                } else if (chatList[index].type == 'review') {
                                  return ReviewBox(chatModel: chatList[index]);
                                } else if (chatList[index].type == 'result') {
                                  return ResultBox(chatModel: chatList[index]);
                                }
                                return Text(chatList[index].msg.toString());
                              },
                            );
                          },
                        ),
                      ),
                      Builder(
                        builder: (con) {
                          if (roomModel.spyCrater.toString() == "null") {
                            return CreateSpyBox();
                          } else if (roomModel.spyCrater ==
                                  PrefService.getUID() &&
                              roomModel.lastMsgSender != PrefService.getUID()) {
                            return RightWrongBtn();
                          }
                          return const SizedBox();
                        },
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
