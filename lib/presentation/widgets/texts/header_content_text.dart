import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/style/textfield_theme.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/description_text.dart';

class HeaderContentText extends StatelessWidget {
  final String header;
  final Text content;

  HeaderContentText({
    @required this.header,
    @required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Theme(
        data: TextFieldTheme.primaryTextFieldStyle,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DescriptionText(
              title: header,
              color: ColorUtil.primaryColor,
              fontSize: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}
