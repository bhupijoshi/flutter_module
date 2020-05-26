import 'dart:convert';
import 'package:flutter_in_sd/news/models/dh_channels.dart';
import 'dh_netwrok_request.dart';

class DHChannelsRequest {
  Future <DHChannels> fetchAvailableChannels() async {
    String serviceName = '/api/v2/syndication/channels?';
    String params = 'pfm=96&';
    final response = await DHNetworkRequest(serviceName: serviceName,queryParams: params).preformRequest();
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      DHChannels allChannels = DHChannels.fromJson(jsonResponse['data']);
      return allChannels;
    } else {
      throw Exception('error while loading channels');
    }
  }
}