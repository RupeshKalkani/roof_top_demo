import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roof_top_demo/common_file/color.dart';
import 'package:roof_top_demo/common_file/loaders.dart';
import 'package:roof_top_demo/common_file/methods.dart';
import 'package:roof_top_demo/common_file/sizer.dart';
import 'package:roof_top_demo/common_file/style.dart';
import 'package:roof_top_demo/model/room_model.dart';
import 'package:roof_top_demo/model/user_model.dart';
import 'package:roof_top_demo/screen/home/home_controller.dart';
import 'package:roof_top_demo/service/pref_service.dart';
import 'package:roof_top_demo/service/user_service.dart';

class MatchesList extends StatelessWidget {
  MatchesList({super.key});

  final HomeController controller = Get.put(HomeController(),permanent: true);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: UserService.getMatchesUserList(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const SmallLoader();
        }

        List<RoomModel> roomList = snapshot.data!.docs
            .map((e) => RoomModel.fromJson(e.data()))
            .toList();
        return ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: roomList.length,
          itemBuilder: (con, index) {
            String userId = "";
            if(roomList[index].uidList?[0] == PrefService.getUID()){
              userId = roomList[index].uidList?[1] ?? '';
            }else{
              userId = roomList[index].uidList?[0] ?? '';
            }
            return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: UserService.getUsersStream(userId),
              builder: (context, snapshot2) {

                if(snapshot2.data == null){
                  return const SizedBox();
                }
                UserModel userModel = UserModel.fromJson(snapshot2.data!.data()!);
                return InkWell(
                  onTap: () => controller.onOnlineUserTap(userModel),
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.33.w, left: 5.33.w),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 2.66.w),
                          height: 10.w,
                          width: 10.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.green,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            userModel.name ?? 'User',
                            style: styleW500S18.copyWith(color: AppColor.white),
                          ),
                        ),
                        SizedBox(width: 2.66.w),
                        Visibility(
                          visible: false,
                          // visible: (roomList[index].newMsg?[getUID()] ?? 0) != 0,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            padding: EdgeInsets.all(1.w),
                            child: Text(roomList[index].newMsg?[PrefService.getUID()]?.toString() ?? ''),
                          ),
                        ),
                        SizedBox(width: 6.2.w),
                      ],
                    ),
                  ),
                );
              }
            );
          },
        );
      },
    );
  }
}
