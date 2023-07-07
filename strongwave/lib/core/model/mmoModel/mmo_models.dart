// To parse this JSON data, do
//
//     final mmoGames = mmoGamesFromJson(jsonString);

import 'dart:convert';

class MmoGames {
  int id;
  String title;
  String shortDescription;
  String thumbnail;
  String mainImage;
  String articleContent;
  String articleUrl;

  MmoGames({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.thumbnail,
    required this.mainImage,
    required this.articleContent,
    required this.articleUrl,
  });

  factory MmoGames.fromRawJson(String str) =>
      MmoGames.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MmoGames.fromJson(Map<String, dynamic> json) => MmoGames(
        id: json["id"],
        title: json["title"],
        shortDescription: json["short_description"],
        thumbnail: json["thumbnail"],
        mainImage: json["main_image"],
        articleContent: json["article_content"],
        articleUrl: json["article_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "short_description": shortDescription,
        "thumbnail": thumbnail,
        "main_image": mainImage,
        "article_content": articleContent,
        "article_url": articleUrl,
      };
}
