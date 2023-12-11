import 'package:get/get.dart';
import 'package:roof_top_demo/common_file/helpers.dart';
import 'package:roof_top_demo/common_file/methods.dart';
import 'package:roof_top_demo/model/user_model.dart';
import 'package:roof_top_demo/screen/chat/chat_controller.dart';
import 'package:roof_top_demo/screen/chat/chat_screen.dart';
import 'package:roof_top_demo/screen/login/login_screen.dart';
import 'package:roof_top_demo/service/auth_service.dart';
import 'package:roof_top_demo/service/pref_service.dart';
import 'package:roof_top_demo/service/user_service.dart';
import 'package:roof_top_demo/utils/pref_keys.dart';

class HomeController extends GetxController {
  UserModel userData = UserModel();
  bool loader = false;

  Future<void> init() async {
    await getUserDetail();
  }

  Future<void> getUserDetail() async {
    loader = true;
    update(['loader']);
    try {
      final model = await UserService.getUserModel(PrefService.getUID());
      if (model != null) {
        userData = model;
      }
    } catch (e) {
      showErrorMsg(e.toString());
    }
    loader = false;
    update(['loader']);
  }

  Future<void> onLogoutTap() async {
    await AuthService.logoutUser();
    await PrefService.clear();
    Get.offAll(() => LoginScreen());
  }

  Future<void> setUserOnline() async {
    await UserService.updateUserData(
      userData.copyWith(isOnline: true),
    );
  }

  Future<void> setUserOffline() async {
    await UserService.updateUserData(
      userData.copyWith(isOnline: false),
    );
  }

  void onOnlineUserTap(UserModel user) {
    final ChatController controller =
        Get.put(ChatController(), permanent: true);

    controller.init(userModel: user);
    Get.to(() => ChatScreen());
  }
}
