import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_in_sd/news/models/chanels.dart';
import 'dh_netwrok_request.dart';

class DHChannelsRequest {
  final List<SDChanels> sdChanels = [
    SDChanels(
      chanelName: "Headlines",
      iconData: Icons.directions_car,
    ),
    SDChanels(
      chanelName: "Entertainment",
      iconData: Icons.directions_transit,
    ),
    SDChanels(
      chanelName: "Daily Share",
      iconData: Icons.directions_bike,
    ),
  ];
  Future <List<SDChanels>> fetchAvailableChannels() async {
    String serviceName = '/api/v2/syndication/channels?';
    String params = 'pfm=80&';
    final response = await DHNetworkRequest(serviceName: serviceName,queryParams: params).preformRequest();
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(json);
      return sdChanels;
    } else {
      throw Exception('error while loading channels');
    }
  }
}