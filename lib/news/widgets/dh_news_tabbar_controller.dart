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
  Map<String, Object> _cxeData;
  DHChannels _channels;
  static const platfrom = const MethodChannel('com.adlok/info');

  @override
  void initState() {
    super.initState();
    _getNewsCxeData().then((value) {
      _cxeData = value;
      _fetchAvailableChannels();
    });
  }

  void _fetchAvailableChannels() {
    DHChannelsRequest().fetchAvailableChannels().then((DHChannels channels) {
      if (_cxeData != null &&
          _cxeData.containsKey('channels')) {
        List<dynamic> cxeChannelsData = _cxeData['channels'];
        List<DHChannel> _list = [];
        cxeChannelsData.forEach((element) {
          for (var i = 0; i < channels.allChannels.length; i++) {
            var aChannel = channels.allChannels[i];
            if (element.containsKey('id') &&
                element['id'] == aChannel.channelId) {
              _list.add(aChannel);
            }
          }
        });
        int selectedTab = _cxeData['selectedChannel'];
        var aChannel;
        if ( 0 < selectedTab && selectedTab <= _list.length) {
          aChannel = _list[selectedTab-1];
          aChannel.selectedState = true;
          channels.initialSelected = selectedTab-1;
        } else {
          aChannel = _list[0];
          aChannel.selectedState = true;
        }
        channels.allChannels = _list;
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

  Future<Map<String, Object>> _getNewsCxeData() async {
    if (runModuleIndependent) {
      String jsonString =
          '{"channelsData":{"channels":[{"name":"Headline","id":"1"},{"name":"Entertainment","id":"4178"},{"name":"Daily Share","id":"4324"}],"selectedChannel":2}}';
      Map<String, Object> cxeMap = json.decode(jsonString);
      return cxeMap['channelsData'];
    } else {
      String jsonString;
      Map<String, Object> cxeMap;
      try {
        jsonString = await platfrom.invokeMethod('getNewsCxe');
      } catch (e) {
        print(e);
      } 
      cxeMap = jsonDecode(jsonString);
      if (cxeMap != null && cxeMap.containsKey('channelsData')) {
        return cxeMap['channelsData'];
      } else {
        return Map();
      }
    }
  }
}
