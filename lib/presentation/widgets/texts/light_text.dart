import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

class LightText extends StatelessWidget {
  const LightText({
    Key key,
    @required this.text,
    this.horizontalPadding,
  }) : super(key: key);

  final String text;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? sy(8)),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: sy(10),
              fontWeight: FontWeight.w200,
              letterSpacing: 1,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
