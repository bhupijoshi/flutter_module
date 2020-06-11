/*
 * @author Bhoopi
 * @email bhoopendra.joshi@snapdeal.com
 * @create date 2020-05-28 12:02:02
 * @modify date 2020-05-28 12:02:02
 * @desc [News list view]
 */
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../requests/dh_requests/dh_article_tracking_request.dart';
import './ui/dh_daily_share_cell.dart';
import './ui/dh_entertainment_cell.dart';
import './ui/dh_headline_cell.dart';
import '../requests/dh_requests/dh_items_request.dart';
import '../models/dh_articles_model.dart';
import '../models/dh_channels.dart';
import './dh_divider_widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';


class DHNewsContainer extends StatefulWidget {
  final DHChannel aChannel;
  DHNewsContainer({@required this.aChannel});
  @override
  _DHNewsContainerState createState() => _DHNewsContainerState();
}

class _DHNewsContainerState extends State<DHNewsContainer> {
  static const platfrom = const MethodChannel('com.adlok/info');

  String _loadingMessage = "Laoding content...";
  ScrollController _scrollController = ScrollController();
  List<DHArticle> _listOfArticles = [];
  String _urlForContent = '';
  List<DHArticle> _visibleArticles = [];

  @override
  void initState() {
    _listOfArticles = [];
    _urlForContent = '';
    super.initState();
    if (widget.aChannel != null) {
      _fetchArticles(widget.aChannel.contentUrl);
    }
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchArticles(_urlForContent);
      }
    });
  }

// Get Articles from DH Server
  void _fetchArticles(String contentUrl) {
    DHItemsRequest()
        .fetchDhNewsArticles(contentUrl)
        .then((DHArticles dhArticles) {
      setState(() {
        if (dhArticles != null && dhArticles.articleCount > 0) {
          _urlForContent = dhArticles.nextPageUrl;
          _listOfArticles.addAll(dhArticles.articles);
          //Send tracking for article visibility
          _sendNewsVisibilityTracking(dhArticles.articles, dhArticles.trackUrl);
        } else {
          _loadingMessage = "No content available.";
        }
      });
    });
  }

  void _sendNewsVisibilityTracking(List<DHArticle> articles, String trackUrl) {
    // DHArticleTrackingRequest(articleList: articles).sendTrackData(trackUrl);
  }
  @override
  Widget build(BuildContext context) {
    return _listOfArticles.length > 0
        ? ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) {
              return index == _listOfArticles.length
                  ? Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        CupertinoActivityIndicator(),
                      ],
                    )
                  : Column(
                      children: <Widget>[
                        _getWidget(index),
                        DHDividerWidget(),
                      ],
                    );
            },
            itemCount: _listOfArticles.length + 1,
          )
        : Center(
            child: CupertinoActivityIndicator(
                animating: true,
              ),
          );
  }

  Widget _getWidget(int index) {
    var anArticle = _listOfArticles[index];
    if (anArticle.isVisibleOnScreen == false) {
      anArticle.isVisibleOnScreen = true;
      _visibleArticles.add(anArticle);
    }
    if (widget.aChannel.channelId == '1') {
      return DHHeadlineCell(
        article: anArticle,
        shareFunction: _shareAction,
        deeplinkFunction: _openArticleDeeplinkInNative,
      );
    } else if (widget.aChannel.channelId == '2') {
      return DHEntertainmentCell(
        dhArticle: anArticle,
        shareFunction: _shareAction,
        deeplinkFunction: _openArticleDeeplinkInNative,
      );
    } else {
      return DHDailyShareCell(
        dailyShareArticle: anArticle,
        shareFunction: _shareAction,
        deeplinkFunction: _openArticleDeeplinkInNative,
      );
    }
  }

  void _shareAction(String imageUrl, String msg, String shareUrl) async {

    _sendShareInfoToNative(imageUrl, msg, shareUrl);
  }

  // open article in partner webview in native code
   void _openArticleDeeplinkInNative(String deeplink) {
    Map<String,dynamic> infomation = Map();
    infomation['deeplink'] = deeplink;
    try {
      platfrom.invokeMethod('openArticle', infomation);
    } catch (e) {
    }
  }

  // send share info to native app

  void _sendShareInfoToNative( String imageUrl, String title, String shareUrl) {
    Map<String,dynamic> infomation = Map();
    infomation['title'] = title;
    infomation['imgUrl'] = imageUrl;
    infomation['shareUrl'] = shareUrl;

    infomation['shareData'] = title+" "+"https://m.snapdeal.com/home?viewInApp=true&renderApp=true&plink=1&purl="+shareUrl;

    try {
      platfrom.invokeMethod('shareArticle', infomation);
    } catch (e) {
    }

  }
}
