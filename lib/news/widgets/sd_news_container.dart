import 'package:flutter/material.dart';
import 'package:flutter_in_sd/news/models/articles_model.dart';
import 'package:flutter_in_sd/news/widgets/sd_divider_widget.dart';
import './sd_article_widget.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';

class SDNewsContainer extends StatefulWidget {
  final String chanelName;
  SDNewsContainer({@required this.chanelName});
  @override
  _SDNewsContainerState createState() => _SDNewsContainerState();
}

class _SDNewsContainerState extends State<SDNewsContainer> {
  List<DHArticle> _listOfArticles = [];
  Future<String> loadArticlesFromAssets() async {
    return await rootBundle.loadString('json/headlines.json');
  }

  Future<DHArticles> parseArticlesJson() async {
    String jsonString = await loadArticlesFromAssets();
    final jsonResponse = json.decode(jsonString);
    DHArticles dhArticles = DHArticles.fromJson(jsonResponse['data']);
    return dhArticles;
  }

  @override
  void initState() {
    super.initState();
    parseArticlesJson().then((DHArticles dhArticles) {
      setState(() {
        _listOfArticles = dhArticles.articles;
      });
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: _listOfArticles.map((anArticle) {
          return Column(
            children: <Widget>[
              SDArticleWidget(
            anArticle: anArticle,
          ),
          SDDividerWidget(),
            ],
          );
        }).toList(),
      ),
    );
  }
}
// <Widget>[
//           SDArticleWidget(),
//           SDDividerWidget(),
//           SDArticleWidget(),
//           SDDividerWidget(),
//           SDArticleWidget(),
//         ],
