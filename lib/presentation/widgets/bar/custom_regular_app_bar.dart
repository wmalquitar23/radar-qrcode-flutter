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
  final bool hasLeading;

  const CustomRegularAppBar({
    Key key,
    this.title,
    this.body,
    this.backgroundColor,
    this.onBackTap,
    this.titleColor,
    this.titleFontWeight,
    this.isContainerScrollable = true,
    this.hasLeading = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hasLeading ? AppBar(
        backgroundColor: backgroundColor ?? ColorUtil.primaryColor,
        centerTitle: true,
        elevation: 0.0,
        leading: hasLeading
            ? GestureDetector(
                onTap: onBackTap ??
                    () {
                      Navigator.pop(context);
                    },
                child: Icon(
                  Icons.arrow_back,
                  color: ColorUtil.primaryTextColor,
                ),
              )
            : Container(),
        title: Text(
          title ?? "",
          style: TextStyle(
            fontWeight: titleFontWeight ?? FontWeight.w600,
            color: titleColor ?? ColorUtil.primaryTextColor,
          ),
        ),
      ) : null,
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
