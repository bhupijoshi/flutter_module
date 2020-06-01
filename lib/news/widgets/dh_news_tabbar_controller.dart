/*
 * @author Bhoopi
 * @email bhoopendra.joshi@snapdeal.com
 * @create date 2020-05-28 13:09:53
 * @modify date 2020-05-28 13:09:53
 * @desc [Tab controller]
 */
import 'package:flutter/material.dart';
import '../models/dh_channels.dart';
import '../requests/dh_requests/dh_channels_request.dart';
import './dh_news_container.dart';
import '../models/dh_news_constant.dart';

class DHNewsTabbarController extends StatefulWidget {
  @override
  _DHNewsTabbarControllerState createState() => _DHNewsTabbarControllerState();
}

class _DHNewsTabbarControllerState extends State<DHNewsTabbarController> {
  DHChannels _channels;

  @override
  void initState() {
    super.initState();
    _fetchAvailableChannels();
  }

  void _fetchAvailableChannels() {
    DHChannelsRequest().fetchAvailableChannels().then((DHChannels channels) {
      setState(() {
        _channels = channels;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _channels != null
        ? DefaultTabController(
            length: _channels.allChannels.length,
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
                  isScrollable: false,
                  tabs: _channels.allChannels.map((aChanel) {
                    return Tab(
                      text: aChanel.channelName,
                    );
                  }).toList(),
                ),
              ),
              body: TabBarView(
                children: _channels.allChannels.map((aChanel) {
                  return DHNewsContainer(
                    aChannel: aChanel,
                  );
                }).toList(),
              ),
            ),
          )
        : Scaffold(
            body: Center(
              child: Text(
                'Loading....',
              ),
            ),
          );
  }
}
