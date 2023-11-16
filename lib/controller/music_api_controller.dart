import 'package:get/get.dart';
import 'package:music_app/bindings/music_model.dart';
import 'package:music_app/services/api_service.dart';

class MusikController extends GetxController {
  var musics = <Musics>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getMusik();
  }

  void getMusik() async {
    try {
      isLoading(true);
      var response = await ApiService().getMusik();
      musics.value = response;
    } finally {
      isLoading(false);
    }
  }
}
