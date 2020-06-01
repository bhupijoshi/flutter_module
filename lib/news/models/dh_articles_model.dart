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
  final DHArticleShareInfo articleShareInfo; // used for share the the article
  final DHArticleThumbnailInfo articleThumbnailInfo; // thumbnail of the article, In daily share we are getting thumbnail instead of images
  final List<String> articleTags; // tags associated with article
  final String authorName; // article author name


  DHArticle({
    this.articleId,
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
    this.articlesRecommendationTs,
    this.articleShareInfo,
    this.articleThumbnailInfo,
    this.articleTags,
    this.authorName,
  });

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
      articleShareInfo: DHArticleShareInfo().parseShareInfo(json['shareInfo']),
      articleThumbnailInfo: DHArticleThumbnailInfo().parseThumbnailInfo(json['thumbnail']),
      articleTags: parseArticleTags(json['tags']),
      authorName: json['authorName'],

    );
  }

// parse images for the article
  static List<String> parseImages(imageJson) {
    if (imageJson == null) {
      return [];
    }
    List<String> images = List<String>.from(imageJson);
    List<String> imageUrls = [];
    images.forEach((imageUrl) {
      imageUrl = imageUrl.replaceAll('{CMD}', 'resize');
      imageUrl = imageUrl.replaceAll('{W}x{H}_{Q}', '375x100_50');
      imageUrl = imageUrl.replaceAll('{EXT}', 'png');
      imageUrls.add(imageUrl);
    });
    return imageUrls;
  }

  static List<String> parseArticleTags(tagJson){
    if (tagJson == null) {
      return [];
    }
    return List<String>.from(tagJson);
  }
}

class DHArticleShareInfo {
  String shareString;
  String shareUrl;
  DHArticleShareInfo({this.shareString, this.shareUrl});

  DHArticleShareInfo parseShareInfo(Map<String, Object> shareInfoJson) {
    shareString = shareInfoJson['shareString'];
    shareUrl = shareInfoJson['shareUrl'];
    return this;
  }
}

class DHArticleThumbnailInfo {
  String url;
  double height;
  double width;
  DHArticleThumbnailInfo({this.url, this.height, this.width});
  DHArticleThumbnailInfo parseThumbnailInfo(Map<String, Object> thumbnailJson) {
    if (thumbnailJson == null) {
      return this;
    }
    url = thumbnailJson['url'];
    url = url.replaceAll('{CMD}', 'resize');
    url = url.replaceAll('{W}x{H}_{Q}', '375x100_50');
    url = url.replaceAll('{EXT}', 'png');
    height = thumbnailJson['height'];
    width = thumbnailJson['width'];
    return this;
  }
}
