
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
    if (articlesJson == null && articlesJson['rows'] == null) {
      return [];
    }
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
  final DHShareInfo shareInfo;

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
      this.articlesRecommendationTs,this.shareInfo});

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
      shareInfo: DHShareInfo().parseShareInfo(json['shareInfo']),
    );
  }

  static List<String> parseImages(imageJson) {
    if (imageJson == null) {
        return [];
    }
    List<String> images = List<String>.from(imageJson);
    List<String> imageUrls = [];
     images.forEach((imageUrl){
      imageUrl = imageUrl.replaceAll('{CMD}', 'resize');
      imageUrl = imageUrl.replaceAll('{W}x{H}_{Q}', '375x100_50');
      imageUrl = imageUrl.replaceAll('{EXT}', 'png');
      imageUrls.add(imageUrl);
    });
    return imageUrls;
  }
}

class DHShareInfo{
  String shareString;
  String shareUrl;
  DHShareInfo({this.shareString,this.shareUrl});

  DHShareInfo parseShareInfo(Map<String,Object>shareInfoJson){
    shareString = shareInfoJson['shareString'];
    shareUrl = shareInfoJson['shareUrl'];
    return this;
  }

}
