/*
 * @author Bhoopi
 * @email bhoopendra.joshi@snapdeal.com
 * @create date 2020-05-28 13:09:53
 * @modify date 2020-05-28 13:09:53
 * @desc [Tab controller]
 */
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/dh_channels.dart';
import '../requests/dh_requests/dh_channels_request.dart';
import './dh_news_container.dart';
import '../models/dh_news_constant.dart';
import 'package:flutter/services.dart';

class DHNewsTabbarController extends StatefulWidget {
  @override
  _DHNewsTabbarControllerState createState() => _DHNewsTabbarControllerState();
}

class _DHNewsTabbarControllerState extends State<DHNewsTabbarController> {
  Map<String, Object> _channelsData;
  DHChannels _channels;

  static const platform = const MethodChannel('com.snapdeal.main/flutter/bridge/channel');

  @override
  void initState() {
    super.initState();
    _getHostAppNewsData().then((value) {
      _channelsData = value;
      _fetchAvailableChannels();
    });
  }

  void _fetchAvailableChannels() {
    DHChannelsRequest().fetchAvailableChannels().then((DHChannels channels) {
      if (_channelsData != null && _channelsData.containsKey('rows')) {
        DHChannels _channelsFilter = DHChannels.fromJson(_channelsData);
        List<DHChannel> _list = [];
        _channelsFilter.allChannels.forEach((channel) {
          for (var i = 0; i < channels.allChannels.length; i++) {
            var aChannel = channels.allChannels[i];
            if (channel.channelId == aChannel
                .channelId) { //If Channel id match and Name available in Host App data
              if (channel.channelName != null &&
                  channel.channelName.length > 0) {
                aChannel.channelName = channel.channelName;
              }
              _list.add(aChannel);
            }
          }
        });

        if(_list.length > 0) { //do not update list, Fallback to original, if list is empty after filter so that page is not empty
          int selectedTab = _channelsData['selectedChannel'];
          var aChannel;
          if (0 < selectedTab && selectedTab <= _list.length) {
            aChannel = _list[selectedTab - 1];
            aChannel.selectedState = true;
            channels.initialSelected = selectedTab - 1;
          } else {
            aChannel = _list[0];
            aChannel.selectedState = true;
          }
          channels.allChannels = _list;
        }
      }

      if (!mounted) return;
      setState(() {
        _channels = channels;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _channels != null
        ? DefaultTabController(
          initialIndex: _channels.initialSelected,
            length: _channels.allChannels.length,
            child: Scaffold(
              appBar: AppBar(
                brightness: Brightness.light,
                backgroundColor: Colors.white,
                flexibleSpace: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      unselectedLabelColor: tabBarUnSelectedTextColor,
                      labelColor: tabBarSelectedTextColor,
                      indicatorColor: tabBarSelectedTextColor,
                      isScrollable: _channels.allChannels.length < 4 ? false : true,
                      tabs: _channels.allChannels.map((aChanel) {
                        return Tab(
                          child: Text(
                            aChanel.channelName,
                            style: TextStyle(
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
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
              child: CupertinoActivityIndicator(
                animating: true,
              ),
            ),
          );
  }

  Future<Map<String, Object>> _getHostAppNewsData() async {
    if (runModuleIndependent) {//Test Data
      String jsonString =
          '{"channelsData":{"rows":[{"name":"Headline","id":"1"},{"name":"Entertainment","id":"4178"},{"name":"Daily Share","id":"4324"}],"selectedChannel":2}}';
      Map<String, Object> channelsData = json.decode(jsonString);
      return channelsData['channelsData'];
    } else {
      String jsonString;
      Map<String, Object> channelsData;
      try {
        jsonString = await platform.invokeMethod('getHostAppData');
      } catch (e) {
        print(e);
      }
      channelsData = jsonDecode(jsonString);
      if (channelsData != null && channelsData.containsKey('channelsData')) {
        return channelsData['channelsData'];
      } else {
        return Map();
      }
    }
  }
}
