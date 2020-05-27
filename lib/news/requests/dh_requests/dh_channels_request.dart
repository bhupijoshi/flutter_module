import 'dart:convert';
import '../../models/dh_channels.dart';
import './dh_netwrok_request.dart';
import '../../models/dh_news_constant.dart';

class DHChannelsRequest {
  Future <DHChannels> fetchAvailableChannels() async {
    String serviceName = '/api/v2/syndication/channels?';
    String params = 'pfm=96&langCode=en&partner=$partnerCode&puid=test123';
    final response = await DHNetworkRequest(queryParams: params,requestUrl: baseUrl+serviceName).preformRequest();
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      DHChannels dhChannels = DHChannels.fromJson(jsonResponse['data']);
      return dhChannels;
    } else {
      throw Exception('error while loading channels');
    }
  }
}