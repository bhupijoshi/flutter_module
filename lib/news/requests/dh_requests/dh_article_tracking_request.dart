/**
 * @author Bhoopi
 * @email bhoopendra.joshi@snapdeal.com
 * @create date 2020-05-28 17:33:34
 * @modify date 2020-05-28 17:33:34
 * @desc [This is a request class for the sending article tracking if they visible]
 */

import 'package:flutter/material.dart';
import '../../models/dh_news_constant.dart';
import '../../models/articles_model.dart';
import '../../requests/dh_requests/dh_netwrok_request.dart';
class DHArticleTrackingRequest {
  final List<DHArticle> articleList;
  DHArticleTrackingRequest({@required this.articleList});

  // send Track data to DH
  void sendTrackData() {
    List<Map<String, Object>> trackData = articleList.map((article) {
      Map<String, Object> info = Map();
      info['trackData'] = article.articleTrackData;
      info['id'] = article.articleId;
      return info;
    }).toList();
    Map<String, Object> trackDataMap = Map();
    trackDataMap['viewedDate'] =
        DateTime.now().millisecondsSinceEpoch.toString();
    trackDataMap['stories'] = trackData;
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