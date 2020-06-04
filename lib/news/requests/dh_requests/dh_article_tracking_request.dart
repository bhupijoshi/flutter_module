/*
 * @author Bhoopi
 * @email bhoopendra.joshi@snapdeal.com
 * @create date 2020-05-28 17:33:34
 * @modify date 2020-05-28 17:33:34
 * @desc [This is a request class for the sending article tracking if they visible]
 */

import 'package:flutter/material.dart';
import '../../models/dh_articles_model.dart';
import '../../requests/dh_requests/dh_netwrok_request.dart';
import '../../models/dh_news_constant.dart';

class DHArticleTrackingRequest {
  final List<DHArticle> articleList;
  DHArticleTrackingRequest({@required this.articleList});

  // send Track data to DH
  void sendTrackData(String trackUrl) {
    List<String> components = trackUrl.split('?');
    String url = components[0] + '?';
    String params = components.length > 1 ? components[1] : "";
    params = '&langCode=en&partner=$partnerCode&puid=test123';


    // String params = 'partner=$partnerCode&puid=test123';
    // String serviceName = '/tracking?';


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
    var request = DHNetworkRequest(
      queryParams: params,
      requestUrl: url ,
      httpMethod: 'POST',
    );
    request.postBody = trackDataMap;
    request.preformRequest().then((response){
      if (response.statusCode == 204) {
        print('Tracking sent successfully');
      }else{
        print('Tracking error Code ${response.statusCode}');
      }
    });
  }
}