import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';

class LabelText extends StatelessWidget {
  final String title;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;

  LabelText(
      {@required this.title,
      this.fontWeight = FontWeight.w400,
      this.fontSize = 16,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(
          height: 1.0,
          fontSize: fontSize,
          color: color ?? ColorUtil.primaryTextColor,
          fontWeight: fontWeight,
        ));
  }
}
