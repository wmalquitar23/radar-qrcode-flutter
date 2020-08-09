import 'package:flutter/material.dart';

class MobileStatusMarginTop extends StatelessWidget {
  final Widget child;

  MobileStatusMarginTop({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: child,
    );
  }
}
