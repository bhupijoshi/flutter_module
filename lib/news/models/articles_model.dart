
class DHArticles {
  final int articleCount;
  final String nextPageUrl;
  final int pageNumber;
  final String pageMarker;
  final String trackUrl;
  final List<DHArticle> articles;
  DHArticles(
      {this.articleCount,
      this.nextPageUrl,
      this.pageNumber,
      this.articles,
      this.pageMarker,
      this.trackUrl});

  factory DHArticles.fromJson(Map<String, dynamic> json) {
    return DHArticles(
      articleCount: json['count'],
      nextPageUrl: json['nextPageUrl'],
      pageNumber: json['pageNumber'],
      pageMarker: json['pageMarker'],
      trackUrl: json['trackUrl'],
      articles: parseArticles(json),
    );
  }

  static List<DHArticle> parseArticles(articlesJson) {
    var list = articlesJson['rows'] as List;
    List<DHArticle> articles = list.map((article) {
      return DHArticle.fromJson(article);
    }).toList();
    return articles;
  }
}

class DHArticle {
  final String articleId;
  final String articleTitle;
  final String articleDescription;
  final String deepLinkUrl;
  final int publishTime;
  final List<String> images;
  final String source;
  final String articleType;
  final String articleTrackData;
  final String articleSourceLogo;
  final String articleUiType;
  final int articlesImagesCount;
  final int articlesRecommendationTs;

  DHArticle(
      {this.articleId,
      this.articleTitle,
      this.articleDescription,
      this.deepLinkUrl,
      this.publishTime,
      this.images,
      this.source,
      this.articleType,
      this.articleTrackData,
      this.articleSourceLogo,
      this.articleUiType,
      this.articlesImagesCount,
      this.articlesRecommendationTs});

  factory DHArticle.fromJson(Map<String, dynamic> json) {
    return DHArticle(
      articleId: json['id'],
      articleTitle: json['title'],
      articleDescription: json['description'],
      deepLinkUrl: json['deepLinkUrl'],
      publishTime: json['publishTime'],
      images: parseImages(json['images']),
      source: json['source'],
      articleType: json['type'],
      articleTrackData: json['trackData'],
      articleSourceLogo: json['sourceLogo'],
      articleUiType: json['uiType'],
      articlesImagesCount: json['imagesCount'],
      articlesRecommendationTs: json['recommendationTs'],
    );
  }

  static List<String> parseImages(imageJson) {
    List<String> images = List<String>.from(imageJson);
    return images;
  }
}
