import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';

class CustomAppBar extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData icon;
  final Color iconColor;
  final String imageAsset;
  final Color backgroundColor;

  const CustomAppBar(
      {Key key,
      this.onTap,
      @required this.icon,
      this.backgroundColor,
      this.iconColor,
      @required this.imageAsset})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Icon(
                icon,
                color: iconColor ?? ColorUtil.primaryBackgroundColor,
              ),
            ),
            Container(
              child: ExtendedImage.asset(
                imageAsset,
                width: 80,
              ),
            )
          ],
        ),
      ),
    );
  }
}
