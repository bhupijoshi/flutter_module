import 'dart:convert';
import '../../models/articles_model.dart';
import './dh_netwrok_request.dart';

class DHItemsRequest {
  Future<DHArticles> fetchDhNewsArticles(String channelContentUrl) async {
    List<String> components = channelContentUrl.split('?');
    String url = components[0] + '?';
    String params = components.length > 1 ? components[1] : "";
    final response = await DHNetworkRequest(
      queryParams: params,
      requestUrl: url,
    ).preformRequest();
    if (response.statusCode == 200) {
      DHArticles dhArticles;
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['data']['rows'] != null) {
        dhArticles = DHArticles.fromJson(jsonResponse['data']);
      }
      if (jsonResponse['track'] !=null) {
        _sendComscoreTracking(jsonResponse['track']);
      }
      return dhArticles;
    } else {
      throw Exception('error while loading Articles');
    }
  }

  void _sendComscoreTracking(Map<String,Object> comsTrackJson){
    for (var url in DHTrackInfo().parseComScoreUrl(comsTrackJson).comscoreUrls) {
      DHNetworkRequest(requestUrl: url,queryParams: "").performComScoreRequest().then((response){
        if (response.statusCode == 200) {
          print('comscore tracking pushed successfully');
        }
      });
    }
  }

}

// comscore tracking 
class DHTrackInfo{
  List<String> comscoreUrls;
  DHTrackInfo({this.comscoreUrls});
  DHTrackInfo parseComScoreUrl(Map<String,Object> comsMap){
    comscoreUrls = List<String>.from(comsMap['comscoreUrls']); 
    return this;
  }
}