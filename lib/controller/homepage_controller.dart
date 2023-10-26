import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/models/app_images.dart';
import 'package:music_app/controller/theme_controller.dart';

final themeController = Get.find<ThemeController>();

class HomePageController extends GetxController {
  RxList<String> musicType = [
    'Rekomendasi',
    'Top Indo',
    'J-Tracks',
    'Hip-Hop',
    'Indie',
    'K-Pop',
    'Rock',
    'Jazz',
    'EDM',
  ].obs;

  RxList<String> imagesPath = [
    AppImages.music5,
    AppImages.music6,
    AppImages.music7,
    AppImages.music8,
  ].obs;

  void selectedIndex(int index, BuildContext context) {
    if (index == 3) {
      showModalBottomSheet(
        context: context,
        // backgroundColor: Theme.of(context).colorScheme.background,
        builder: (_) {
          return Container(
            color: Theme.of(context).colorScheme.background,
            height: 100,
            width: double.infinity,
            child: Center(
              child: Transform.scale(
                scale: 1,
                child: ElevatedButton(
                  onPressed: () {
                    themeController.toggleTheme();
                  },
                  child: const Text('Ubah Tema'),
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
