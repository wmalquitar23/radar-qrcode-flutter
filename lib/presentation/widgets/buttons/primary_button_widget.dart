import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key key,
    @required this.text,
    this.height,
    this.width,
    this.fontSize,
    this.radius,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final double height;
  final double width;
  final double fontSize;
  final double radius;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height ?? 60.0,
      width: this.width ?? double.infinity,
      child: FlatButton(
        onPressed: onPressed ?? () {},
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(this.radius ?? 25)),
        color: ColorUtil.primaryColor,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16 ?? this.fontSize,
          ),
        ),
      ),
    );
  }
}
