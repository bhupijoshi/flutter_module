/*
 * @author Bhoopi
 * @email bhoopendra.joshi@snapdeal.com
 * @create date 2020-05-28 12:02:02
 * @modify date 2020-05-28 12:02:02
 * @desc [News list view]
 */
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

class DHNewsContainer extends StatefulWidget {
  final DHChannel aChannel;
  DHNewsContainer({@required this.aChannel});
  @override
  _DHNewsContainerState createState() => _DHNewsContainerState();
}

class _DHNewsContainerState extends State<DHNewsContainer>
    with AutomaticKeepAliveClientMixin<DHNewsContainer> {
  String _loadingMessage = "Laoding content...";
  ScrollController _scrollController = ScrollController();
  List<DHArticle> _listOfArticles = [];
  String _urlForContent = '';

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
          DHArticleTrackingRequest(articleList: dhArticles.articles)
              .sendTrackData(dhArticles.trackUrl);
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
            child: Text(
              _loadingMessage,
            ),
          );
  }

  Widget _getWidget(int index) {
    if (widget.aChannel.channelId == '1') {
      return DHHeadlineCell(
        article: _listOfArticles[index],
      );
    } else if (widget.aChannel.channelId == '2') {
      return DHEntertainmentCell(
        dhArticle: _listOfArticles[index],
      );
    } else {
      return DHDailyShareCell(
        dailyShareArticle: _listOfArticles[index],
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
