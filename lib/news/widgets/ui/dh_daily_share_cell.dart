/*
 * @author Bhoopi
 * @email bhoopendra.joshi@snapdeal.com
 * @create date 2020-06-01 20:52:56
 * @modify date 2020-06-01 20:52:56
 * @desc [Daily share Cell]
 */

import 'package:flutter/material.dart';
import 'package:flutter_in_sd/news/widgets/ui/dh_article_ui_component/dh_tags.dart';
import 'dh_article_ui_component/dh_author_name.dart';
import '../../models/dh_articles_model.dart';
import 'dh_article_ui_component/dh_title.dart';
import 'dh_article_ui_component/dh_thumbnail.dart';
import 'dh_article_ui_component/dh_share_icon.dart';

class DHDailyShareCell extends StatelessWidget {
  final DHArticle dailyShareArticle;
  final Function shareFunction;
  final Function deeplinkFunction;
  DHDailyShareCell({
    @required this.dailyShareArticle,
    this.shareFunction,
    @required this.deeplinkFunction,
  });
  @override
  Widget build(BuildContext context) {
    bool isThumbnail = false;
    if (dailyShareArticle.articleThumbnailInfo != null &&
        dailyShareArticle.articleThumbnailInfo.url.length > 0) {
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
              height: isThumbnail ? 329 : 134,
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
                    DHTitle(titleText: dailyShareArticle.articleTitle,maxLine: 1,),
                    SizedBox(
                      height: 11.25,
                    ),
                    dailyShareArticle.articleTags.length > 0
                        ? DHTags(
                            allTags: dailyShareArticle.articleTags,
                          )
                        : SizedBox(
                            height: 0,
                          ),
                    SizedBox(
                      height: 15,
                    ),
                    isThumbnail
                        ? DHThumbnail(
                            thumbUrl:
                                dailyShareArticle.articleThumbnailInfo.url,
                          )
                        : SizedBox(
                            height: 0,
                          ),
                    SizedBox(
                      height: 18,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          DHAuthorName(
                            authorNameText: dailyShareArticle.authorName,
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

   void _shareArticle(){
    String imageUrl = '';
    if (dailyShareArticle.articleThumbnailInfo != null && dailyShareArticle.articleThumbnailInfo.url.length > 0) {
      imageUrl = dailyShareArticle.articleThumbnailInfo.url;
    }
    shareFunction(imageUrl, dailyShareArticle.articleTitle,dailyShareArticle.articleShareInfo.shareUrl);
  }

  void _openNewsDetailPage(BuildContext context) {
    deeplinkFunction(dailyShareArticle.deepLinkUrl);
  }
}
