/*
 * @author Bhoopi
 * @email bhoopendra.joshi@snapdeal.com
 * @create date 2020-06-01 15:53:44
 * @modify date 2020-06-01 15:53:44
 * @desc [Responsible for share icon]
 */

import 'package:flutter/material.dart';

class DHShareIcon extends StatelessWidget {
  final String iconName;
  DHShareIcon({@required this.iconName});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16.0,
      width: 14.0,
      child: GestureDetector(
        onTap: () => {},
        child: Image.asset(iconName),
      ),
    );
  }
}
