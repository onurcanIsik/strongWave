import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:strongwave/core/model/newsPaper/news_paper.dart';

class NewsPaperApi {
  Dio dio = Dio();
  String country = 'tr';
  late String url;
  List<Article> article = [];

  Future<List<Article>?> fetchNewsPaper() async {
    url =
        "https://newsapi.org/v2/top-headlines?country=$country&category=business&apiKey=0a7dffba826b4b34bfa6a8b35bf6bcba";
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      try {
        final jsonData = response.data as Map<String, dynamic>;
        final articlesJson = jsonData['articles'] as List<dynamic>;
        return article =
            articlesJson.map((json) => Article.fromJson(json)).toList();
      } catch (err) {
        debugPrint('NewsPaper Hata $err');
      }
    }
    return null;
  }
}
