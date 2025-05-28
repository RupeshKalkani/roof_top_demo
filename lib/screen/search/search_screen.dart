import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roof_top_demo/model/movie_model.dart';
import 'package:roof_top_demo/screen/search/search_page_controller.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchPageController searchController = Get.put(SearchPageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search for a movie',
                border: OutlineInputBorder(),
              ),
              onChanged: searchController.onSearchChange,
              onSubmitted: (query) {
                searchController.onSearchTap(query);
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GetBuilder<SearchPageController>(
                id: 'loader',
                builder: (controller) {
                  if (controller.movieList.isEmpty) {
                    return const Center(child: Text('No movies found'));
                  }

                  return ListView.builder(
                    itemCount: controller.movieList.length,
                    itemBuilder: (context, index) {
                      final movie = controller.movieList[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          leading: movie.posterPath.isNotEmpty
                              ? Image.network(
                                  'https://image.tmdb.org/t/p/w92${movie.posterPath}',
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.movie, size: 50),
                          title: Text(movie.title),
                          subtitle: Text('Release Date: ${movie.releaseDate}'),
                          onTap: () {
                            _showMovieDetails(context, movie);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMovieDetails(BuildContext context, Movie movie) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(movie.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(movie.overview),
            const SizedBox(height: 10),
            Text('Release Date: ${movie.releaseDate}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
