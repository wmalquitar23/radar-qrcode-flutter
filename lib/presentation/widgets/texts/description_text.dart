import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';

class DescriptionText extends StatelessWidget {
  final String title;
  final FontWeight fontWeight;
  final double fontSize;
  final TextAlign textAlign;
  final Color color;

  DescriptionText(
      {@required this.title,
      this.fontWeight,
      this.fontSize = 13,
      this.textAlign = TextAlign.center,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        height: 1.5,
        fontSize: fontSize,
        color: color ?? ColorUtil.primarySubTextColor,
        fontWeight: fontWeight ?? FontWeight.w600,
      ),
      textAlign: textAlign ?? TextAlign.left,
    );
  }
}
