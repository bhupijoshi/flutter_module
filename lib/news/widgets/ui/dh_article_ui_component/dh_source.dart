/*
 * @author Bhoopi
 * @email bhoopendra.joshi@snapdeal.com
 * @create date 2020-06-01 20:57:08
 * @modify date 2020-06-01 20:57:08
 * @desc [Source ]
 */

import 'package:flutter/material.dart';
import '../../../models/dh_news_constant.dart';

class DHSource extends StatelessWidget {
  final String sourceName;
  DHSource({@required this.sourceName});
  @override
  Widget build(BuildContext context) {
    return Text(
      sourceName,
      style: TextStyle(
        color: sourceTextColor,
        fontSize: 13.0,
      ),
    );
  }
}