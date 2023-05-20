// To parse this JSON data, do
//
//     final homePageResponse = homePageResponseFromJson(jsonString);

import 'dart:convert';

HomePageResponse homePageResponseFromJson(String str) => HomePageResponse.fromJson(json.decode(str));

String homePageResponseToJson(HomePageResponse data) => json.encode(data.toJson());

class HomePageResponse {
  int? success;
  String? message;
  Data? data;
  DateTime? timestamp;

  HomePageResponse({
    this.success,
    this.message,
    this.data,
    this.timestamp,
  });

  factory HomePageResponse.fromJson(Map<String, dynamic> json) => HomePageResponse(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    timestamp: DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "timestamp": timestamp?.toIso8601String(),
  };

  @override
  String toString() {
    return 'HomePageResponse{success: $success, message: $message, data: $data, timestamp: $timestamp}';
  }
}

class Data {
  List<News>? news;
  List<Article>? trandingBulletin;
  String? specialityName;
  List<Article>? latestArticle;
  List<Article>? exploreArticle;
  List<Article>? trandingArticle;
  Article? article;
  List<Article>? bulletin;
  int? sId;

  Data({
    this.news,
    this.trandingBulletin,
    this.specialityName,
    this.latestArticle,
    this.exploreArticle,
    this.trandingArticle,
    this.article,
    this.bulletin,
    this.sId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    news: List<News>.from(json["news"].map((x) => News.fromJson(x))),
    trandingBulletin: List<Article>.from(json["trandingBulletin"].map((x) => Article.fromJson(x))),
    specialityName: json["specialityName"],
    latestArticle: List<Article>.from(json["latestArticle"].map((x) => x)),
    exploreArticle: List<Article>.from(json["exploreArticle"].map((x) => Article.fromJson(x))),
    trandingArticle: List<Article>.from(json["trandingArticle"].map((x) => Article.fromJson(x))),
    article: Article.fromJson(json["article"]),
    bulletin: List<Article>.from(json["bulletin"].map((x) => Article.fromJson(x))),
    sId: json["sId"],
  );

  Map<String, dynamic> toJson() => {
    "news": List<dynamic>.from(news!.map((x) => x.toJson())),
    "trandingBulletin": List<dynamic>.from(trandingBulletin!.map((x) => x.toJson())),
    "specialityName": specialityName,
    "latestArticle": List<dynamic>.from(latestArticle!.map((x) => x)),
    "exploreArticle": List<dynamic>.from(exploreArticle!.map((x) => x.toJson())),
    "trandingArticle": List<dynamic>.from(trandingArticle!.map((x) => x.toJson())),
    "article": article!.toJson(),
    "bulletin": List<dynamic>.from(bulletin!.map((x) => x.toJson())),
    "sId": sId,
  };

  @override
  String toString() {
    return 'Data{news: $news, trandingBulletin: $trandingBulletin, specialityName: $specialityName, latestArticle: $latestArticle, exploreArticle: $exploreArticle, trandingArticle: $trandingArticle, article: $article, bulletin: $bulletin, sId: $sId}';
  }
}

class Article {
  int? id;
  String? articleTitle;
  String? redirectLink;
  String? articleImg;
  String? articleDescription;
  String? specialityId;
  int? rewardPoints;
  String? keywordsList;
  String? articleUniqueId;
  int? articleType;
  String? createdAt;

  Article({
    this.id,
    this.articleTitle,
    this.redirectLink,
    this.articleImg,
    this.articleDescription,
    this.specialityId,
    this.rewardPoints,
    this.keywordsList,
    this.articleUniqueId,
    this.articleType,
    this.createdAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    id: json["id"],
    articleTitle: json["articleTitle"],
    redirectLink: json["redirectLink"],
    articleImg: json["articleImg"],
    articleDescription: json["articleDescription"],
    specialityId: json["specialityId"],
    rewardPoints: json["rewardPoints"],
    keywordsList: json["keywordsList"],
    articleUniqueId: json["articleUniqueId"],
    articleType: json["articleType"],
    // createdAt: DateTime.parse(json["createdAt"]),
    createdAt: json["createdAt"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "articleTitle": articleTitle,
    "redirectLink": redirectLink,
    "articleImg": articleImg,
    "articleDescription": articleDescription,
    "specialityId": specialityId,
    "rewardPoints": rewardPoints,
    "keywordsList": keywordsList,
    "articleUniqueId": articleUniqueId,
    "articleType": articleType,
    "createdAt": createdAt,
  };

  @override
  String toString() {
    return 'Article{id: $id, articleTitle: $articleTitle, redirectLink: $redirectLink, articleImg: $articleImg, articleDescription: $articleDescription, specialityId: $specialityId, rewardPoints: $rewardPoints, keywordsList: $keywordsList, articleUniqueId: $articleUniqueId, articleType: $articleType, createdAt: $createdAt}';
  }
}

class News {
  int? id;
  String? title;
  String? url;
  String? urlToImage;
  String? description;
  String? speciality;
  String? newsUniqueId;
  int? trendingLatest;
  DateTime? publishedAt;

  News({
    this.id,
    this.title,
    this.url,
    this.urlToImage,
    this.description,
    this.speciality,
    this.newsUniqueId,
    this.trendingLatest,
    this.publishedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
    id: json["id"],
    title: json["title"],
    url: json["url"],
    urlToImage: json["urlToImage"],
    description: json["description"],
    speciality: json["speciality"],
    newsUniqueId: json["newsUniqueId"],
    trendingLatest: json["trendingLatest"],
    publishedAt: DateTime.parse(json["publishedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "url": url,
    "urlToImage": urlToImage,
    "description": description,
    "speciality": speciality,
    "newsUniqueId": newsUniqueId,
    "trendingLatest": trendingLatest,
    "publishedAt": publishedAt?.toIso8601String(),
  };

  @override
  String toString() {
    return 'News{id: $id, title: $title, url: $url, urlToImage: $urlToImage, description: $description, speciality: $speciality, newsUniqueId: $newsUniqueId, trendingLatest: $trendingLatest, publishedAt: $publishedAt}';
  }
}
