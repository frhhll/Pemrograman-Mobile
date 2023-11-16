import 'dart:convert';
import 'package:http/http.dart';
import 'package:music_app/bindings/music_model.dart';

class ApiService {
  final endPointUrl = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=834ad62dc383498ea7d2e41f5c111cd9");

  Future<List<Musics>> getMusik() async {
    Response res = await get(endPointUrl);

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      List<dynamic> body = json['articles'];
      List<Musics> musik =
          body.map((dynamic item) => Musics.fromJson(item)).toList();
      return musik;
    } else {
      throw ("Can't get the Articles");
    }
  }
}
