import 'package:get/get.dart';
import 'package:roof_top_demo/model/category_model.dart';
import 'package:roof_top_demo/screen/home/api/home_api.dart';
import 'package:roof_top_demo/screen/login/login_screen.dart';
import 'package:roof_top_demo/screen/search/search_screen.dart';
import 'package:roof_top_demo/service/pref_service.dart';

class HomeController extends GetxController {
  bool loader = true;
  List<CategoryData> categoryList = [];

  @override
  void onInit() {
    getCategoryFromApi();
    super.onInit();
  }

  Future<void> getCategoryFromApi() async {
    final model = await HomeApi.fetchCategory();

    if (model != null) {
      categoryList = model.genres ?? [];
    }
    loader = false;
    update(['loader']);
  }

  Future<void> onSearchTap() async {
    Get.to(() => const SearchView());
  }

  Future<void> onLogoutTap() async {
    await PrefService.clear();
    Get.offAll(() => LoginScreen());
  }
}
