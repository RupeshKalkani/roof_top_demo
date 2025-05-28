
import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  List<CategoryData>? genres;

  CategoryModel({
    this.genres,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    genres: json["genres"] == null ? [] : List<CategoryData>.from(json["genres"]!.map((x) => CategoryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "genres": genres == null ? [] : List<dynamic>.from(genres!.map((x) => x.toJson())),
  };
}

class CategoryData {
  int? id;
  String? name;

  CategoryData({
    this.id,
    this.name,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
