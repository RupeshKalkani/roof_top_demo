import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roof_top_demo/common_file/loaders.dart';
import 'package:roof_top_demo/screen/home/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Categories'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: controller.onSearchTap,
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: controller.onLogoutTap,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: GetBuilder<HomeController>(
        id: "loader",
        builder: (con) {
          return StackedLoader(
            loading: controller.loader,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columns
                childAspectRatio: 3, // Width to height ratio
                crossAxisSpacing: 10, // Spacing between columns
                mainAxisSpacing: 10, // Spacing between rows
              ),
              padding: const EdgeInsets.all(10),
              itemCount: controller.categoryList.length,
              itemBuilder: (context, index) {
                final genre = controller.categoryList[index];
                return Card(
                  color: Colors.blueAccent,
                  child: Center(
                    child: Text(
                      genre.name ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
