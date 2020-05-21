import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import './news/widgets/sd_news_tabbar_controller.dart';
import './sd_dynamic_wdgets/widgets/sd_dynamic_widget_page.dart';


void main() => runApp(_widgetForRoute(window.defaultRouteName));

Widget _widgetForRoute(String route) {
  switch (route) {
    case 'myApp':
      return MyApp();
    case 'SDSample':
      return SDSample();
    case 'BannerApp':
      return BannerApp();
    case 'SDNewsApp':
      return SDNewsApp();
    default:
      return SDDynamicWidgetApp();
  }
}

//void main() => runApp(MyApp());

@pragma('vm:entry-point')
void myOtherEntrypoint() => runApp(BannerApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyAppHomePage(),
    );
  }
}

@pragma('vm:entry-point')
void sdSamplepApp() => runApp(SDSample());

class SDSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SDSamplePage(),
    );
  }
}

class SDSamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 100,
            child: Card(
              color: Colors.green,
              elevation: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class MyAppHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 164,
            child: Column(
              children: <Widget>[
                Text(
                  'Main Dart File',
                ),
                Card(
                  elevation: 10,
                  color: Colors.blue,
                  child: Image.network(
                      'https://image.shutterstock.com/image-photo/panorama-beautiful-countryside-romania-sunny-260nw-1302294157.jpg'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
      home: SDNewsPage(),
    );
  }
}

class SDNewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SDNewsTabbarController();
  }
}


// Dynamic widget page
class SDDynamicWidgetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SDDynamicWidgetPage(),
    );
  }
}


