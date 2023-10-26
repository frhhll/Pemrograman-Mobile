import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/views/image_picker.dart';
import 'views/homepage_view.dart';
import 'theme/app_theme.dart';
import 'controller/theme_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final themeController = Get.put(ThemeController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: themeController.isLightMode.value
                ? AppThemeClass.lightTheme
                : AppThemeClass.darkTheme,
            home: const HomePage(),
            initialRoute: '/', // Atur rute awal
            getPages: [
              GetPage(name: '/', page: () => const HomePage()),
              GetPage(name: '/image_picker', page: () => ImagePage()),
            ]);
      },
    );
  }
}
