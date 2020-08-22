import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';

class TitleAndContentWithDividerWrapper extends StatelessWidget {
  const TitleAndContentWithDividerWrapper({
    Key key,
    @required this.title,
    @required this.content,
  }) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline5.copyWith(
                color: ColorUtil.primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 5.0),
        Text(
          content,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        Divider(),
      ],
    );
  }
}
