/*
 * @author Bhoopi
 * @email bhoopendra.joshi@snapdeal.com
 * @create date 2020-06-01 15:30:16
 * @modify date 2020-06-01 15:30:16
 * @desc [description]
 */

import 'package:flutter/material.dart';

class DHThumbnail extends StatelessWidget {
  final String thumbUrl;
  DHThumbnail({@required this.thumbUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 185,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
              thumbUrl,
            ),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
