import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/style/textfield_theme.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/description_text.dart';

class CustomTextField extends StatelessWidget {
  final TextFormField child;
  final String label;
  final bool isRichText;

  const CustomTextField({Key key, this.label, this.child, this.isRichText = false})
      : super(key: key);

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
                title: label,
                color: ColorUtil.primaryColor,
                fontSize: 10,
              ),
              isRichText
                  ? Container(
                      height: 50.0,
                      child: child,
                    )
                  : Container(
                      height: 30.0,
                      child: child,
                    ),
            ],
          ),
        ));
  }
}
