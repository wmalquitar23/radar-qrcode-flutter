import 'package:flutter/cupertino.dart';
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
    this.color,
    this.isLoading = false,
    this.fontWeight,
    this.hasIcon = false,
    this.icon,
  }) : super(key: key);

  final String text;
  final double height;
  final double width;
  final double fontSize;
  final double radius;
  final VoidCallback onPressed;
  final Color color;
  final bool isLoading;
  final FontWeight fontWeight;
  final bool hasIcon;
  final dynamic icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height ?? 55.0,
      width: this.width ?? double.infinity,
      child: FlatButton(
        onPressed: onPressed ?? () {},
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(this.radius ?? 25)),
        color: color ?? ColorUtil.primaryColor,
        child: isLoading
            ? CupertinoActivityIndicator()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  hasIcon ? icon : Container(),
                  Text(
                    text,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: this.fontSize ?? 14,
                        fontWeight: fontWeight ?? FontWeight.w600),
                  ),
                ],
              ),
      ),
    );
  }
}
