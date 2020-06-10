/*
 * @author Bhoopi
 * @email bhoopendra.joshi@snapdeal.com
 * @create date 2020-06-03 11:20:51
 * @modify date 2020-06-03 11:20:51
 * @desc [description]
 */
import 'package:flutter/material.dart';
import '../../../models/dh_news_constant.dart';

class DHTags extends StatelessWidget {
  final List<String> allTags;

  DHTags({@required this.allTags});
  @override
  Widget build(BuildContext context) {
    return Text(
      _getTagString(),
      style: TextStyle(
        color: sourceTextColor,
        fontSize: 15.0,
      ),
      maxLines: 1,
      textAlign: TextAlign.left,
    );
  }

  String _getTagString() {
    String tagString = '';
    allTags.forEach((element) {
      tagString = tagString + ' ' + element;
    });
    return tagString;
  }
}
