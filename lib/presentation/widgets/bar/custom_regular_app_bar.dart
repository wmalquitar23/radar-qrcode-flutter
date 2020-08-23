import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';

class CustomRegularAppBar extends StatelessWidget {
  final String title;
  final Widget body;
  final Color backgroundColor;

  const CustomRegularAppBar(
      {Key key, this.title, this.body, this.backgroundColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor ?? ColorUtil.primaryColor,
        centerTitle: true,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: ColorUtil.primaryTextColor,
          ),
        ),
        title: Text(
          title ?? "",
          style: TextStyle(color: ColorUtil.primaryTextColor),
        ),
      ),
      body: body,
    );
  }
}
