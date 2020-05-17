import 'package:flutter/material.dart';
import 'package:flutter_in_sd/news/widgets/sd_news_container.dart';
import '../models/chanels.dart';
import '../models/sd_news_constant.dart';

class SDNewsTabbarController extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: sdChanels.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('News',style: TextStyle(color: textColor),),
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
            return SDNewsContainer();
          }).toList(),
        ),
      ),
    );
  }
}
