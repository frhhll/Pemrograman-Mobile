import 'package:get/get.dart';
import 'package:music_app/binding/article_model.dart';
import 'package:music_app/service/api_service.dart';

class ArticleController extends GetxController {
  var articles = <Article>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getArticles();
  }

  void getArticles() async {
    try {
      isLoading(true);
      var response = await ApiService().getArticle();
      articles.value = response;
    } finally {
      isLoading(false);
    }
  }
}
