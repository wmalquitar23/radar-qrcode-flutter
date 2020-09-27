import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';

class PrimaryButtonWithIcon extends StatelessWidget {
  const PrimaryButtonWithIcon({
    Key key,
    @required this.text,
    this.color,
    this.height,
    this.width,
    this.fontSize,
    this.radius,
    this.onPressed,
    this.icon,
  }) : super(key: key);

  final String text;
  final Color color;
  final double height;
  final double width;
  final double fontSize;
  final double radius;
  final VoidCallback onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height ?? 60.0,
      width: this.width ?? double.infinity,
      child: FlatButton(
        onPressed: onPressed ?? () {},
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(this.radius ?? 25)),
        color: color ?? ColorUtil.primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null ? icon : Image.asset('assets/images/app/qr-code.png'),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14 ?? this.fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
