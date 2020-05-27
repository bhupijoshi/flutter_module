import 'package:flutter/material.dart';
import '../models/dh_channels.dart';
import '../requests/dh_requests/dh_channels_request.dart';
import './sd_news_container.dart';
import '../models/dh_news_constant.dart';

class SDNewsTabbarController extends StatefulWidget {
  @override
  _SDNewsTabbarControllerState createState() => _SDNewsTabbarControllerState();
}

class _SDNewsTabbarControllerState extends State<SDNewsTabbarController> {
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
            length: _channels.channelCount,
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
                  isScrollable: true,
                  tabs: _channels.allChannels.map((aChanel) {
                    return Tab(
                      text: aChanel.channelName,
                    );
                  }).toList(),
                ),
              ),
              body: TabBarView(
                children: _channels.allChannels.map((aChanel) {
                  return SDNewsContainer(
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
