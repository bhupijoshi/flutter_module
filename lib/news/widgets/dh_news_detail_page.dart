/**
 * @author Bhoopi
 * @email bhoopendra.joshi@snapdeal.com
 * @create date 2020-05-28 13:09:45
 * @modify date 2020-05-28 13:09:45
 * @desc [Detail page for news]
 */
import 'package:flutter/material.dart';
import '../models/dh_articles_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DHNewsDetailPage extends StatelessWidget {
  final DHArticle dhArticle;
  DHNewsDetailPage({@required this.dhArticle});

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
