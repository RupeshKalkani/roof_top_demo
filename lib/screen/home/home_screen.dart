import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roof_top_demo/common_file/color.dart';
import 'package:roof_top_demo/common_file/loaders.dart';
import 'package:roof_top_demo/common_file/methods.dart';
import 'package:roof_top_demo/common_file/sizer.dart';
import 'package:roof_top_demo/common_file/style.dart';
import 'package:roof_top_demo/model/user_model.dart';
import 'package:roof_top_demo/screen/home/home_controller.dart';
import 'package:roof_top_demo/screen/home/widget/live_user_list.dart';
import 'package:roof_top_demo/screen/home/widget/matches_list.dart';
import 'package:roof_top_demo/service/pref_service.dart';
import 'package:roof_top_demo/service/user_service.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final HomeController controller = Get.put(HomeController(), permanent: true);

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.setUserOnline();
    } else {
      controller.setUserOffline();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: GetBuilder<HomeController>(
          id: "loader",
          builder: (con) {
            return StackedLoader(
              loading: controller.loader,
              child: SafeArea(
                child: Column(
                  children: [
                    StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream:
                            UserService.getUsersStream(PrefService.getUID()),
                        builder: (context, userSnap) {
                          if (userSnap.data == null) {
                            return const SizedBox();
                          }
                          UserModel userModel =
                              UserModel.fromJson(userSnap.data?.data() ?? {});
                          return Row(
                            children: [
                              SizedBox(width: 4.2.w),
                              Expanded(
                                child: Text(
                                  "Welcome ${userModel.name ?? ''} !",
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.white),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4.w, vertical: 1.w),
                                child: Text(
                                  "Point ${userModel.totalPoint ?? '0'}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: controller.onLogoutTap,
                                icon: const Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          );
                        }),
                    TabBar(
                      tabs: [
                        SizedBox(
                          height: 15.w,
                          child: Center(
                            child: Text(
                              "Live User",
                              style:
                                  styleW400S18.copyWith(color: AppColor.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.w,
                          child: Center(
                            child: Text(
                              "Active Matches",
                              style:
                                  styleW400S18.copyWith(color: AppColor.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.33.w),
                    Expanded(
                      child: TabBarView(
                        children: [
                          LiveUserList(),
                          MatchesList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
