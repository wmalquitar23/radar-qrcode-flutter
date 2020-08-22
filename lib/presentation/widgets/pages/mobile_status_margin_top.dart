import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';

class MobileStatusMarginTop extends StatelessWidget {
  final Widget child;

  MobileStatusMarginTop({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorUtil.primaryBackgroundColor,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: child,
    );
  }
}
