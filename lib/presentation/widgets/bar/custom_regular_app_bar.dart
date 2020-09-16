import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';

class CustomRegularAppBar extends StatelessWidget {
  final String title;
  final Widget body;
  final Color backgroundColor;
  final Color titleColor;
  final FontWeight titleFontWeight;
  final VoidCallback onBackTap;
  final bool isContainerScrollable;

  const CustomRegularAppBar({
    Key key,
    this.title,
    this.body,
    this.backgroundColor,
    this.onBackTap,
    this.titleColor,
    this.titleFontWeight,
    this.isContainerScrollable = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor ?? ColorUtil.primaryColor,
        centerTitle: true,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: onBackTap ??
              () {
                Navigator.pop(context);
              },
          child: Icon(
            Icons.arrow_back,
            color: ColorUtil.primaryTextColor,
          ),
        ),
        title: Text(
          title ?? "",
          style: TextStyle(
            fontWeight: titleFontWeight ?? FontWeight.w600,
            color: titleColor ?? ColorUtil.primaryTextColor,
          ),
        ),
      ),
      body: isContainerScrollable
          ? SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: body,
            )
          : Container(
              child: body,
            ),
    );
  }
}
