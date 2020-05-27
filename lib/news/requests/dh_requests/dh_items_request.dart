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
      return dhArticles;
    } else {
      throw Exception('error while loading Articles');
    }
  }
}
