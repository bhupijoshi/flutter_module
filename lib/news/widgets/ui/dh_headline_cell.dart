/*
 * @author Bhoopi
 * @email bhoopendra.joshi@snapdeal.com
 * @create date 2020-06-01 15:04:01
 * @modify date 2020-06-01 15:04:01
 * @desc [Headline cell]
 */
import 'package:flutter/material.dart';
import 'dh_article_ui_component/dh_source.dart';
import '../../models/dh_articles_model.dart';
import 'dh_article_ui_component/dh_title.dart';
import 'dh_article_ui_component/dh_thumbnail.dart';
import 'dh_article_ui_component/dh_share_icon.dart';
import 'dh_article_ui_component/dh_publish_time.dart';
import '../../models/dh_news_constant.dart';

class DHHeadlineCell extends StatelessWidget {
  final DHArticle article;
  final Function shareFunction;
  final Function deeplinkFunction;
  DHHeadlineCell({
    @required this.article,
    this.shareFunction,
    @required this.deeplinkFunction,
  });
  @override
  Widget build(BuildContext context) {
    bool isThumbnail = false;
    if (article.images.length > 0) {
      isThumbnail = true;
    }
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            onTap: () => _openNewsDetailPage(context),
            child: Container(
              color: Colors.white,
              height: isThumbnail ? 319 : 319 - 185,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 0,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 15.0,
                    ),
                    DHTitle(titleText: article.articleTitle),
                    SizedBox(
                      height: 11.25,
                    ),
                    isThumbnail
                        ? DHThumbnail(
                            thumbUrl: article.images[0],
                          )
                        : SizedBox(
                            height: 0,
                          ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              DHSource(
                                sourceName: article.source,
                              ),
                              SizedBox(width: 3),
                              Container(
                                width: 1,
                                height: 12,
                                color: sourceTextColor,
                              ),
                              SizedBox(width: 3),
                              DHPublishTime(
                                publishTime: article.publishTime,
                              ),
                            ],
                          ),
                          DHShareIcon(
                            iconName: 'images/dh_share.png',
                            shareFunction: _shareArticle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _shareArticle() {
    String imageUrl = '';
    if (article.images.length > 0) {
      imageUrl = article.images[0];
    }
    shareFunction(imageUrl, article.articleTitle);
  }

  void _openNewsDetailPage(BuildContext context) {
    deeplinkFunction(article.deepLinkUrl);
  }
}
