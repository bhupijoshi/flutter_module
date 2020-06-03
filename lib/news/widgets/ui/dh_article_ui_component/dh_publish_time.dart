/*
 * @author Bhoopi
 * @email bhoopendra.joshi@snapdeal.com
 * @create date 2020-06-03 11:45:14
 * @modify date 2020-06-03 11:45:14
 * @desc [description]
 */
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_in_sd/news/models/dh_news_constant.dart';

class DHPublishTime extends StatelessWidget {
  final int publishTime;
  DHPublishTime({@required this.publishTime});
  @override
  Widget build(BuildContext context) {
    return Text(
      _getPublishTimeText(),
      style: TextStyle(
        color: sourceTextColor,
        fontSize: 13.0,
      ),
    );
  }

  String _getPublishTimeText() {
    var publishDT = DateTime.fromMillisecondsSinceEpoch(publishTime);
    var currentDT = DateTime.now();
    var delta = currentDT.difference(publishDT);
    print(DateFormat.yMMMd().format(currentDT).toString());
    print(DateFormat.yMMMd().format(publishDT).toString());
    print('inHours====${delta.inHours}');
    print('inMinutes====${delta.inMinutes}');
    print('inSeconds====${delta.inSeconds}');
    
    if (delta.inHours < 24 && delta.inHours > 0) {
      return '${delta.inHours} hours ago';
    }else if (delta.inMinutes < 60 && delta.inMinutes > 0) {
      return '${delta.inMinutes} mins ago';
    } else if (delta.inSeconds < 60) {
      return '${delta.inSeconds} seconds ago';
    }else{
      return DateFormat.yMMMd().format(publishDT).toString();
    }
  }
}
