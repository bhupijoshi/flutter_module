/*
 * @author Bhoopi
 * @email bhoopendra.joshi@snapdeal.com
 * @create date 2020-05-28 13:09:34
 * @modify date 2020-05-28 13:09:34
 * @desc [Divider used to seperate the two new items]
 */
import 'package:flutter/material.dart';
import '../models/dh_news_constant.dart';

class DHDividerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: seperationColor,
      thickness: 1,
      height: 1,
    );
  }
}
