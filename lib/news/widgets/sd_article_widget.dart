
import 'package:flutter/material.dart';
import 'package:flutter_in_sd/news/models/articles_model.dart';
import 'package:flutter_in_sd/news/widgets/sd_news_detail_page.dart';
import '../models/sd_news_constant.dart';

class SDArticleWidget extends StatelessWidget {
  final DHArticle anArticle;
  SDArticleWidget({@required this.anArticle});

  void _openNewsDetailPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SDNewsDetailPage(dhArticle: anArticle)));
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
                              anArticle.images[0],
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
