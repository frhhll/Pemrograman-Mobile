import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package
import 'package:music_app/components/list_title.dart';
import 'package:music_app/services/api_service.dart';
import 'package:music_app/bindings/music_model.dart';
import 'package:music_app/controller/music_api_controller.dart';

class HomePages extends StatelessWidget {
  static const routeName = '/api';

  final ApiService client = ApiService();

  HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Music News", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: GetX<MusikController>(
        // Use GetX widget
        init: MusikController(), // Initialize your controller
        builder: (articleController) {
          List<Musics> articles = articleController.musics;

          if (articleController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) =>
                  customListTile(articles[index], context),
            );
          }
        },
      ),
    );
  }
}
