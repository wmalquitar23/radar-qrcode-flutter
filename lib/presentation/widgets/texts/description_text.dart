import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';

class DescriptionText extends StatelessWidget {
  final String title;
  final FontWeight fontWeight;
  final double fontSize;
  final TextAlign textAlign;

  DescriptionText(
      {@required this.title,
      this.fontWeight = FontWeight.w700,
      this.fontSize = 13,
      this.textAlign = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        height: 1.0,
        fontSize: fontSize,
        color: ColorUtil.primarySubTextColor,
        fontWeight: FontWeight.w300,
      ),
      textAlign: textAlign ?? TextAlign.left,
    );
  }
}
