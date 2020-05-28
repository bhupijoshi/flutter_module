/**
 * @author Bhoopi
 * @email bhoopendra.joshi@snapdeal.com
 * @create date 2020-05-28 12:02:02
 * @modify date 2020-05-28 12:02:02
 * @desc [News list view]
 */
import 'package:flutter/material.dart';
import 'package:flutter_in_sd/news/requests/dh_requests/dh_article_tracking_request.dart';
import '../requests/dh_requests/dh_items_request.dart';
import '../models/articles_model.dart';
import '../models/dh_channels.dart';
import './dh_divider_widget.dart';
import './dh_article_widget.dart';

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
          DHArticleTrackingRequest(articleList: dhArticles.articles).sendTrackData();
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


}


