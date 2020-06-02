/*
 * @author Bhoopi
 * @email bhoopendra.joshi@snapdeal.com
 * @create date 2020-05-27 21:01:13
 * @modify date 2020-05-27 21:01:13
 * @desc [DH news card which contain Title, Image and Source]
 */

import 'package:flutter/material.dart';
import 'package:flutter_in_sd/news/widgets/ui/dh_article_ui_component/dh_author_name.dart';
import 'package:flutter_in_sd/news/widgets/ui/dh_article_ui_component/dh_share_icon.dart';
import './ui/dh_article_ui_component/dh_thumbnail.dart';
import './ui/dh_article_ui_component/dh_title.dart';
import '../models/dh_articles_model.dart';

class DHArticleWidget extends StatelessWidget {
  final DHArticle anArticle;
  DHArticleWidget({@required this.anArticle});

  void _openNewsDetailPage(BuildContext context) {
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            onTap: () => _openNewsDetailPage(context),
            child: Container(
              color: Colors.white,
              height: 319,
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
                    DHTitle(titleText: anArticle.articleTitle),
                    SizedBox(
                      height: 11.25,
                    ),
                    DHThumbnail(
                      thumbUrl: anArticle.images.length > 0
                          ? anArticle.images[0]
                          : 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2700&q=80',
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          DHAuthorName(
                            authorNameText: anArticle.source,
                          ),
                          DHShareIcon(
                            iconName: 'images/dh_share.png',
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
}
