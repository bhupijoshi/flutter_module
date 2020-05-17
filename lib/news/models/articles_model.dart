class DHArticles{
  final int articleCount;
  final String nextPageUrl;
  final int pageNumber;
  final List<DHArticle> articles;
  DHArticles({this.articleCount,this.nextPageUrl,this.pageNumber,this.articles});

  factory DHArticles.fromJson(Map<String, dynamic> json) {
    return DHArticles(
      articleCount: json['count'],
      nextPageUrl: json[''],
      pageNumber: json[''],
    );
  }


}


class DHArticle{

}