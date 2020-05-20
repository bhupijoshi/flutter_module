import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './pages/sd_demo_page.dart';

class SDDynamicWidgetPage extends StatefulWidget {
  @override
  _SDDynamicWidgetPageState createState() => _SDDynamicWidgetPageState();
}

class _SDDynamicWidgetPageState extends State<SDDynamicWidgetPage> {
  String _widgetJson = '';
  final String networkImageJson = '''
{
  "type": "Container",
  "color": "#FFFFFF",
  "alignment": "center",
  "child": {
    "type": "NetworkImage",
    "src": "https://image.shutterstock.com/image-photo/panorama-beautiful-countryside-romania-sunny-260nw-1302294157.jpg"
  }
}

''';

@override
  void initState() {
    super.initState();
    _widgetsJson().then( (String json){
      setState(() {
         _widgetJson = json;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Title',
        ),
      ),
      body: SDDemoPage(jsonString: _widgetJson),
    );
  }

  Future<String> _widgetsJson() async{
    return await rootBundle.loadString('json/dynamic_widget.json');
  }
}
