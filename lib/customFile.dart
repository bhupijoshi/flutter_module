import 'package:flutter/material.dart';
import 'dart:ui';


void main() => runApp(BannerApp());

@pragma('vm:entry-point')
void sdBannerForTesting() => runApp(BannerApp());

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
            height: 135,
            child: Card(
              elevation: 10,
              color: Colors.blue,
              child: Image.network('https://images.unsplash.com/photo-1530318271774-4f2cb0d1fda1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3889&q=80'),
            ),
          ),
          Text('Sampel Text',),
        ],
      ),
    );
  }
}