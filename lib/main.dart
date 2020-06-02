import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import './news/widgets/dh_news_tabbar_controller.dart';


void main() => runApp(_widgetForRoute(window.defaultRouteName));

Widget _widgetForRoute(String route) {
  switch (route) {
    case 'BannerApp':
      return BannerApp();
    case 'SDNewsApp':
      return SDNewsApp();
    default:
      return SDNewsApp();
  }
}


class BannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BannerAppPage(),
    );
  }
}

class BannerAppPage extends StatefulWidget {
  @override
  _BannerAppPageState createState() => _BannerAppPageState();
}

class _BannerAppPageState extends State<BannerAppPage> {
  String _bannerUrl = '';
  static const platfrom = const MethodChannel('com.adlok/info');

  _BannerAppPageState() {
    _getInformation().then((String url) {
      setState(() {
        _bannerUrl = url;
      });
    });
  }

  void _imageTapped() {
    print('image tapped.');
    platfrom.invokeMethod('imageTapped');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 154,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _bannerUrl.length > 0
                ? GestureDetector(
                    onTap: _imageTapped,
                    child: Card(
                      elevation: 10,
                      color: Colors.blue,
                      child: FittedBox(
                        child: Image.network(
                          _bannerUrl,
                        ),
                      ),
                    ),
                  )
                : Text(
                    "Loading...",
                  ),
          ],
        ),
      ),
    );
  }

  Future<String> _getInformation() async {
    String value;
    try {
      value = await platfrom.invokeMethod('getInformation');
    } catch (e) {
      print(e);
    }
    return value;
  }
}

class SDNewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SDNewsPage(),
    );
  }
}

class SDNewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DHNewsTabbarController();
  }
}


