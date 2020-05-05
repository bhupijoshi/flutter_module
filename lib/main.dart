import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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
      appBar: AppBar(
        title: Text(
          'Flutter in Sanpdeal',
        ),
      ),
      body: Column(
        children: <Widget>[
          Text(
            'First Line',
          ),
          Text(
            'Second Line',
          ),
        ],
      ),
    );
  }
}
