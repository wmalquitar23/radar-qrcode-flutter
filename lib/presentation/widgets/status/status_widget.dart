import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/description_text.dart';

class StatusWidget extends StatelessWidget {
  final bool isVerified;
  final bool iconOnly;

  const StatusWidget({
    Key key,
    this.isVerified,
    this.iconOnly = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return isVerified
        ? Row(
            children: [
              Container(
                child: ExtendedImage.asset(
                  'assets/images/undraw/success.png',
                  width: 15,
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              DescriptionText(
                title: iconOnly ? "" : "VERIFIED",
                color: ColorUtil.primaryTextColor,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ],
          )
        : Row(
            children: [
              Container(
                child: ExtendedImage.asset(
                  'assets/images/undraw/info.png',
                  width: 15,
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              DescriptionText(
                title: iconOnly ? "" : "UNVERIFIED",
                color: ColorUtil.primaryTextColor,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ],
          );
  }
}
