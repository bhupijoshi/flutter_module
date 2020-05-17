import 'package:flutter/material.dart';
import 'package:flutter_in_sd/news/models/articles_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SDNewsDetailPage extends StatelessWidget {
  final DHArticle dhArticle;
  SDNewsDetailPage({@required this.dhArticle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
        ),
        body: WebView(
            initialUrl: dhArticle.deepLinkUrl,
            javascriptMode: JavascriptMode.unrestricted,
          ),
        );
  }
}
