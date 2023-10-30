import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roof_top_demo/common_file/color.dart';
import 'package:roof_top_demo/common_file/loaders.dart';
import 'package:roof_top_demo/common_file/sizer.dart';
import 'package:roof_top_demo/common_file/style.dart';
import 'package:roof_top_demo/model/user_model.dart';
import 'package:roof_top_demo/screen/home/home_controller.dart';
import 'package:roof_top_demo/service/user_service.dart';

class LiveUserList extends StatelessWidget {
  LiveUserList({super.key});

  final HomeController controller = Get.put(HomeController(),permanent: true);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: UserService.getOnlineUserList(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const SmallLoader();
          }
          List<UserModel> userList = snapshot.data!.docs
              .map((e) => UserModel.fromJson(e.data()))
              .toList();
          return ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: userList.length,
            itemBuilder: (con, index) {
              return InkWell(
                onTap: () => controller.onOnlineUserTap(userList[index]),
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
                      Text(
                        userList[index].name ?? 'User',
                        style: styleW500S18.copyWith(color: AppColor.white),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
