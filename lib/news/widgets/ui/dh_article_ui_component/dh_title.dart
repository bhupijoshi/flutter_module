/*
 * @author Bhoopi
 * @email bhoopendra.joshi@snapdeal.com
 * @create date 2020-06-01 15:13:14
 * @modify date 2020-06-01 15:13:14
 * @desc [Responsible for creating the title of the news]
 */
import 'package:flutter/material.dart';
import '../../../models/dh_news_constant.dart';

class DHTitle extends StatelessWidget {
  final String titleText;
  final int maxLine;
  DHTitle({@required this.titleText, this.maxLine =2});
  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: TextStyle(
        color: textColor,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      maxLines: maxLine,
      textAlign: TextAlign.left,
    );
  }
}
