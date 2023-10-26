import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isLightMode = false.obs;

  void toggleTheme() {
    isLightMode.toggle();
  }
}
