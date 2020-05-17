import 'package:flutter/material.dart';
import 'package:flutter_in_sd/news/widgets/sd_divider_widget.dart';
import './sd_article_widget.dart';

class SDNewsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SDArticleWidget(),
          SDDividerWidget(),
          SDArticleWidget(),
          SDDividerWidget(),
          SDArticleWidget(),
        ],
      ),
    );
  }
}
