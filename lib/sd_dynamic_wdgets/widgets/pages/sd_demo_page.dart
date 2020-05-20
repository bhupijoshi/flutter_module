import 'package:flutter/material.dart';
import 'package:dynamic_widget/dynamic_widget.dart';

class SDDemoPage extends StatelessWidget {
  final String jsonString;

  SDDemoPage({@required this.jsonString});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _buildWidget(context),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          return snapshot.hasData
              ? SizedBox.expand(
                  child: snapshot.data,
                )
              : Text(
                  "Loading",
                );
        });
  }

  Future<Widget> _buildWidget(BuildContext context) async {
    return DynamicWidgetBuilder.build(
        jsonString, context, DefaultClickListener());
  }
}

class DefaultClickListener implements ClickListener {
  @override
  void onClicked(String event) {
    print("Receive click event: " + event);
  }
}
