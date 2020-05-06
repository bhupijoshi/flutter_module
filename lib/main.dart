import 'package:flutter/material.dart';
import 'dart:ui';

void main() => runApp(MyApp());


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
      home: BannerAppPage(),
    );
  }
}

class BannerAppPage extends StatelessWidget {
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
              'Custom function',
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