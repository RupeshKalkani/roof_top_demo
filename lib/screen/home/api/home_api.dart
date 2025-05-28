import 'package:roof_top_demo/common_file/helpers.dart';
import 'package:roof_top_demo/model/category_model.dart';
import 'package:roof_top_demo/service/http_service.dart';
import 'package:roof_top_demo/utils/end_points.dart';

class HomeApi {
  static Future<CategoryModel?> fetchCategory() async {
    try {
      final response = await HttpService.getApi(url: EndPoints.category);

      if (response != null && response.statusCode == 200) {
        return categoryModelFromJson(response.body);
      }
    } catch (e) {
      showCatchMsg(e.toString());
    }
    return null;
  }
}
