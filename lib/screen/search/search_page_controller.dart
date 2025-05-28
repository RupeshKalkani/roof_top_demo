import 'dart:async';

import 'package:get/get.dart';
import 'package:roof_top_demo/model/movie_model.dart';
import 'package:roof_top_demo/screen/search/api/search_api.dart';

class SearchPageController extends GetxController {
  bool loader = true;
  List<Movie> movieList = [];
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    loader = false; // Initially, no need to show loader
  }

  void onSearchChange(String value) {
    timer?.cancel();
    timer = Timer(300.milliseconds, () {
      onSearchTap(value);
    });
  }

  Future<void> onSearchTap(String query) async {
    loader = true;
    update(['loader']); // Show loader

    final result = await SearchApi.searchMovies(query);

    if (result != null) {
      movieList = result;
    } else {
      movieList.clear();
    }

    loader = false;
    update(['loader']); // Hide loader after data fetch
  }
}
