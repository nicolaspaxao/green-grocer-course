// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../config/colors.dart';

class AppNameWidget extends StatelessWidget {
  const AppNameWidget({
    Key? key,
    this.greenTitleColor,
     this.titleSize = 30,
  }) : super(key: key);

  final Color? greenTitleColor;
  final double? titleSize;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: titleSize,
        ),
        children: [
          TextSpan(
            text: 'Green',
            style: TextStyle(
              color: greenTitleColor ?? customSwatchColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'grocer',
            style: TextStyle(
              color: customConstrastColor,
            ),
          ),
        ],
      ),
    );
  }
}
