import 'package:flutter/material.dart';
import 'package:flutter_in_sd/news/requests/dh_requests/dh_items_request.dart';
import '../models/articles_model.dart';
import '../models/dh_channels.dart';
import './sd_divider_widget.dart';
import './sd_article_widget.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';

class SDNewsContainer extends StatefulWidget {
  final DHChannel aChannel;
  SDNewsContainer({@required this.aChannel});
  @override
  _SDNewsContainerState createState() => _SDNewsContainerState();
}

class _SDNewsContainerState extends State<SDNewsContainer>
    with AutomaticKeepAliveClientMixin<SDNewsContainer> {
  String _loadingMessage = "Laoding content...";
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
    // parseArticlesJson().then((DHArticles dhArticles) {
    //   setState(() {
    //     _listOfArticles = dhArticles.articles;
    //   });
    // });
    _fetchArticles();
  }

  void _fetchArticles() {
    DHItemsRequest()
        .fetchDhNewsArticles(widget.aChannel.channelId)
        .then((DHArticles dhArticles) {
      if (dhArticles != null && dhArticles.articleCount > 0) {
        if (this.mounted) {
          setState(() {
            _listOfArticles.addAll(dhArticles.articles);
          });
        }
      }else{
        _loadingMessage = "No content available.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _listOfArticles.length > 0
        ? SingleChildScrollView(
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
          )
        : Center(
          child: Text(
              _loadingMessage,
            ),
        );
  }

  @override
  bool get wantKeepAlive => true;
}
