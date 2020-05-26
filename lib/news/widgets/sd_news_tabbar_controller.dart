import 'package:flutter/material.dart';
import 'package:flutter_in_sd/news/requests/dh_requests/dh_channels_request.dart';
import 'package:flutter_in_sd/news/widgets/sd_news_container.dart';
import '../models/chanels.dart';
import '../models/sd_news_constant.dart';

class SDNewsTabbarController extends StatefulWidget {
  @override
  _SDNewsTabbarControllerState createState() => _SDNewsTabbarControllerState();
}

class _SDNewsTabbarControllerState extends State<SDNewsTabbarController> {
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

  @override
  void initState() {
    super.initState();
    _fetchAvailableChannels();
  }

  void _fetchAvailableChannels(){
    DHChannelsRequest().fetchAvailableChannels();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: sdChanels.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'News',
            style: TextStyle(color: textColor),
          ),
          backgroundColor: Colors.white,
          bottom: TabBar(
            unselectedLabelColor: tabBarUnSelectedTextColor,
            labelColor: tabBarSelectedTextColor,
            indicatorColor: tabBarSelectedTextColor,
            tabs: sdChanels.map((aChanel) {
              return Tab(
                text: aChanel.chanelName,
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: sdChanels.map((aChanel) {
            return SDNewsContainer(
              chanelName: 'headlines',
            );
          }).toList(),
        ),
      ),
    );
  }
}
