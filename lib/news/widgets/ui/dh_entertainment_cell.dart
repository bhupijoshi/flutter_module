/*
 * @author Bhoopi
 * @email bhoopendra.joshi@snapdeal.com
 * @create date 2020-06-01 20:52:11
 * @modify date 2020-06-01 20:52:11
 * @desc [Entertainment Cell]
 */

import 'package:flutter/material.dart';
import '../../models/dh_news_constant.dart';
import 'dh_article_ui_component/dh_publish_time.dart';
import '../../models/dh_articles_model.dart';
import 'dh_article_ui_component/dh_title.dart';
import 'dh_article_ui_component/dh_thumbnail.dart';
import 'dh_article_ui_component/dh_share_icon.dart';
import 'dh_article_ui_component/dh_source.dart';

class DHEntertainmentCell extends StatelessWidget {
  final DHArticle dhArticle;
  final Function shareFunction;
  final Function deeplinkFunction;
  DHEntertainmentCell({
    @required this.dhArticle,
    this.shareFunction,
    @required this.deeplinkFunction,
  });

  @override
  Widget build(BuildContext context) {
    bool isThumbnail = false;
    if (dhArticle.images.length > 0) {
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
              height: isThumbnail ? 319 : 134,
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
                    DHTitle(titleText: dhArticle.articleTitle),
                    SizedBox(
                      height: 11.25,
                    ),
                    isThumbnail
                        ? Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              DHThumbnail(
                                thumbUrl: dhArticle.images[0],
                              ),
                              dhArticle.articleType == "video".toUpperCase()
                                  ? Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Container(
                                          height: 32,
                                          width: 32,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Image.asset(
                                            'images/dh_play.png',
                                          ),
                                        )
                                      ],
                                    )
                                  : SizedBox(
                                      height: 0,
                                    ),
                            ],
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
                                sourceName: dhArticle.source,
                              ),
                              SizedBox(width: 3),
                              Container(
                                width: 1,
                                height: 12,
                                color: sourceTextColor,
                              ),
                              SizedBox(width: 3),
                              DHPublishTime(
                                publishTime: dhArticle.publishTime,
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

  void _shareArticle(){
    String imageUrl = '';
    if (dhArticle.images.length > 0) {
      imageUrl = dhArticle.images[0];
    }
    shareFunction(imageUrl, dhArticle.articleTitle,dhArticle.articleShareInfo.shareUrl);
  }

  void _openNewsDetailPage(BuildContext context) {
    deeplinkFunction(dhArticle.deepLinkUrl);
  }
}
