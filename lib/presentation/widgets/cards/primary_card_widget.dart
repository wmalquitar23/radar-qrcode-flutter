import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/properties/shadow_widget.dart';

class PrimaryCardWidget extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final bool isSmall;

  const PrimaryCardWidget({
    @required this.child,
    this.backgroundColor,
    this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: ShadowWidget(
        isSmall: isSmall ?? false,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: backgroundColor ?? ColorUtil.primaryBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(21.0)),
          ),
          child: child,
        ),
      ),
    );
  }
}
