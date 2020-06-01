/*
 * @author Bhoopi
 * @email bhoopendra.joshi@snapdeal.com
 * @create date 2020-06-01 15:41:51
 * @modify date 2020-06-01 15:41:51
 * @desc [description]
 */

import 'package:flutter/material.dart';
import '../../../models/dh_news_constant.dart';

class DHAuthorName extends StatelessWidget {
  final String authorNameText;
  DHAuthorName({@required this.authorNameText});
  @override
  Widget build(BuildContext context) {
    return Text(
      authorNameText,
      style: TextStyle(
        color: sourceTextColor,
        fontSize: 13.0,
      ),
    );
  }
}
