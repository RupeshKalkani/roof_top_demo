import 'dart:convert';

// Convert JSON response to list of movies
List<dynamic> movieModelFromJson(String str) => json.decode(str)['results'];

class Movie {
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;

  Movie({
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'] ?? 'No Title',
      overview: json['overview'] ?? 'No Overview',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? 'Unknown',
    );
  }
}