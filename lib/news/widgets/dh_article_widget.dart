/*
 * @author Bhoopi
 * @email bhoopendra.joshi@snapdeal.com
 * @create date 2020-05-27 21:01:13
 * @modify date 2020-05-27 21:01:13
 * @desc [DH news card which contain Title, Image and Source]
 */

import 'package:flutter/material.dart';
import '../models/dh_articles_model.dart';
import './dh_news_detail_page.dart';
import '../models/dh_news_constant.dart';

class DHArticleWidget extends StatelessWidget {
  final DHArticle anArticle;
  DHArticleWidget({@required this.anArticle});

  void _openNewsDetailPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DHNewsDetailPage(dhArticle: anArticle)));
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
                    Text(
                      anArticle.articleTitle,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 11.25,
                    ),
                    Container(
                      height: 185,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                             anArticle.images.length > 0 ? anArticle.images[0] : 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2700&q=80',
                            ),
                            fit: BoxFit.fitWidth),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            anArticle.source,
                          ),
                          Icon(
                            Icons.share,
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
