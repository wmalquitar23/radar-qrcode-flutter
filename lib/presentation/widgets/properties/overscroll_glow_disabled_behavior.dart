import 'package:flutter/widgets.dart';

class OverScrollGlowDisabledBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
