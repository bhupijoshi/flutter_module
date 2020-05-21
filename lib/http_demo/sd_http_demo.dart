import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SDHTTPDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SDHTTPDemoPage(),
    );
  }
}

class SDHTTPDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP Demo'),
      ),
      body: Center(
        child: Text(
          'Demo Page',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          http.get('http://192.168.1.3:8888/snapdeal/render/dynamic_widget.json').then((response ){
            print(response.statusCode);
            print(jsonDecode(response.body));
          });
        },
        child: Center(
            child: Text(
          'Pres me',
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
