/**
 * @author Bhoopi
 * @email bhoopendra.joshi@snapdeal.com
 * @create date 2020-05-28 12:02:02
 * @modify date 2020-05-28 12:02:02
 * @desc [News list view]
 */
import 'package:flutter/material.dart';
import 'package:flutter_in_sd/news/requests/dh_requests/dh_items_request.dart';
import 'package:flutter_in_sd/news/requests/dh_requests/dh_netwrok_request.dart';
import '../models/articles_model.dart';
import '../models/dh_channels.dart';
import './dh_divider_widget.dart';
import './dh_article_widget.dart';
import '../models/dh_news_constant.dart';

class DHNewsContainer extends StatefulWidget {
  final DHChannel aChannel;
  DHNewsContainer({@required this.aChannel});
  @override
  _DHNewsContainerState createState() => _DHNewsContainerState();
}

class _DHNewsContainerState extends State<DHNewsContainer>
    with AutomaticKeepAliveClientMixin<DHNewsContainer> {
  String _loadingMessage = "Laoding content...";
  List<DHArticle> _listOfArticles = [];

  @override
  void initState() {
    super.initState();
    _listOfArticles = [];
    if (widget.aChannel != null) {
      _fetchArticles(widget.aChannel.contentUrl);
    }
  }

// Get Articles from DH Server
  void _fetchArticles(String contentUrl) {
    DHItemsRequest()
        .fetchDhNewsArticles(contentUrl)
        .then((DHArticles dhArticles) {
      setState(() {
        if (dhArticles != null && dhArticles.articleCount > 0) {
          _listOfArticles.addAll(dhArticles.articles);
          _sendTrackData(dhArticles);
        } else {
          _loadingMessage = "No content available.";
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _listOfArticles.length > 0
        ? ListView.builder(
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  DHArticleWidget(
                    anArticle: _listOfArticles[index],
                  ),
                  DHDividerWidget(),
                ],
              );
            },
            itemCount: _listOfArticles.length,
          )
        : Center(
            child: Text(
              _loadingMessage,
            ),
          );
  }

  @override
  bool get wantKeepAlive => true;

  // send Track data to DH
  void _sendTrackData(DHArticles dhArticles) {
    List<Map<String, Object>> trackData = dhArticles.articles.map((article) {
      Map<String, Object> info = Map();
      info['trackData'] = article.articleTrackData;
      info['id'] = article.articleId;
      return info;
    }).toList();
    Map<String, Object> trackDataMap = Map();
    trackDataMap['viewedDate'] =
        DateTime.now().millisecondsSinceEpoch.toString();
    trackDataMap['stories'] = trackData;
    print(trackDataMap);
    String params = 'partner=$partnerCode&puid=test123';
    String serviceName = '/tracking?';
    var request = DHNetworkRequest(
      queryParams: params,
      requestUrl: baseUrl + serviceName,
      httpMethod: 'POST',
    );
    request.postBody = trackDataMap;
    request.preformRequest().then((response){
      print(response.body);
    });
  }

}


