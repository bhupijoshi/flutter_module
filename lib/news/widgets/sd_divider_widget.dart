import 'package:flutter/material.dart';
import '../models/sd_news_constant.dart';

class SDDividerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: seperationColor,
      thickness: 1,
      height: 1,
    );
  }
}
