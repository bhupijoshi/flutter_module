import 'dart:convert';
import '../../models/articles_model.dart';
import './dh_netwrok_request.dart';

class DHItemsRequest{

  Future<DHArticles> fetchDhNewsArticles(String channelId) async {
    String serviceName = '/api/v2/syndication/items?';
    String params = 'pfm=96&cid=$channelId&';
    final response = await DHNetworkRequest(serviceName: serviceName,queryParams: params).preformRequest();
    if (response.statusCode == 200) {
      DHArticles dhArticles;
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['data']['rows'] != null) {
        dhArticles = DHArticles.fromJson(jsonResponse['data']);
      }
      return dhArticles;
    } else {
      throw Exception('error while loading Articles');
    }
  }
}

