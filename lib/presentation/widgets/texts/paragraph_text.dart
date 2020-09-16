import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/description_text.dart';

class ParagraphText extends StatelessWidget {
  final String label;
  final String content;

  const ParagraphText({
    Key key,
    this.label,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: DescriptionText(
              textAlign: TextAlign.start,
              title: label ?? "",
              color: ColorUtil.primaryColor,
            ),
          ),
          Container(
            child: DescriptionText(
              textAlign: TextAlign.start,
              title: content ?? "",
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              color: ColorUtil.primaryTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
