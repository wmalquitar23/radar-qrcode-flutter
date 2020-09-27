import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/description_text.dart';

class CardInformationWidget extends StatelessWidget {
  final IconData icon;
  final String header;
  final String description;

  const CardInformationWidget(
      {Key key, this.icon, this.header, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            border:
                Border.all(width: 0.5, color: ColorUtil.primarySubTextColor),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Icon(
                    icon,
                    size: 30,
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DescriptionText(
                      title: header ?? "",
                      fontWeight: FontWeight.bold,
                      color: ColorUtil.primaryColor,
                      fontSize: 12,
                    ),
                    DescriptionText(
                      title: description ?? "",
                      fontWeight: FontWeight.w500,
                      color: ColorUtil.primaryTextColor,
                      fontSize: 12,
                      textAlign: TextAlign.start,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
