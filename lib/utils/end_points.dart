import 'package:roof_top_demo/utils/constants.dart';

class EndPoints{
  static const _baseUrl = "https://api.themoviedb.org/3/";

  static const category = "${_baseUrl}genre/movie/list?api_key=${Constants.apiKey}";
  static String search(String query) => "${_baseUrl}search/movie?query=$query&api_key=${Constants.apiKey}";
}