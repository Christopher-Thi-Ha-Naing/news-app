import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/article_model.dart';

class ApiHandler {
  static Future<List<ArticleModel>> getTopTrending({String? limit}) async {
    List<ArticleModel> articles = [];
    try {
      String url =
          "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=1d5a90b39a514d8c874806ee89747203";

      var response = await http.get(Uri.parse(url));
      var data = jsonDecode(response.body);
      List snap = [];

      if (data["status"] == "ok") {
        data["articles"].forEach((element) {
          if (element["urlToImage"] != null && element["description"] != null) {
            snap.add(element);
            articles = ArticleModel.articlesfromSnapshot(snap);
          }
        });
      }
      return articles;
    } catch (err) {
      throw err.toString();
    }
  }

  static Future<List<ArticleModel>> getCategory(String category) async {
    List<ArticleModel> articles = [];
    try {
      String url =
          "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=1d5a90b39a514d8c874806ee89747203";

      var response = await http.get(Uri.parse(url));
      var data = jsonDecode(response.body);
      List snap = [];

      if (data["status"] == "ok") {
        data["articles"].forEach((element) {
          if (element["urlToImage"] != null && element["description"] != null) {
            snap.add(element);
            articles = ArticleModel.articlesfromSnapshot(snap);
          }
        });
      }
      print(articles);
      return articles;
    } catch (err) {
      throw err.toString();
    }
  }

  static Future<List<ArticleModel>> getData({String? limit}) async {
    List<ArticleModel> articles = [];
    try {
      String url =
          "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=1d5a90b39a514d8c874806ee89747203";

      var response = await http.get(Uri.parse(url));
      var data = jsonDecode(response.body);
      List snap = [];

      if (data["status"] == "ok") {
        data["articles"].forEach((element) {
          if (element["urlToImage"] != null && element["description"] != null) {
            snap.add(element);
            articles = ArticleModel.articlesfromSnapshot(snap);
          }
        });
      }
      return articles;
    } catch (err) {
      throw err.toString();
    }
  }
}
