import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';

class MobileStatusMarginTop extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;

  MobileStatusMarginTop({this.child, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? ColorUtil.primaryBackgroundColor,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: child,
    );
  }
}
