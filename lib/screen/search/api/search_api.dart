import 'package:roof_top_demo/common_file/helpers.dart';
import 'package:roof_top_demo/model/movie_model.dart';
import 'package:roof_top_demo/service/http_service.dart';
import 'package:roof_top_demo/utils/end_points.dart';

class SearchApi{
  static Future<List<Movie>?> searchMovies(String query) async {
    try {
      final response = await HttpService.getApi(
        url: EndPoints.search(query),
      );

      if (response != null && response.statusCode == 200) {
        final List<dynamic> movieList = movieModelFromJson(response.body);
        return movieList.map((e) => Movie.fromJson(e)).toList();
      }
    } catch (e) {
      showCatchMsg(e.toString());
    }
    return null;
  }
}