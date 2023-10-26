import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_app/models/image.dart' as MyImage;

class MyImageController extends GetxController {
  RxString selectedImagePath = ''.obs;
  RxList<MyImage.MyImage> imageList = <MyImage.MyImage>[].obs;

  Future<void> pickImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      imageList.add(MyImage.MyImage(
        path: pickedFile.path,
        title: ' ',
        description: ' ',
      ));
    }
  }

  Future<void> pickImageFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      imageList.add(MyImage.MyImage(
        path: pickedFile.path,
        title: ' ',
        description: ' ',
      ));
    }
  }
}
