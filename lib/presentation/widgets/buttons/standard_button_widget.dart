import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../core/utils/color_util.dart';

class StandardButton extends StatelessWidget {
  const StandardButton({
    Key key,
    @required this.text,
    this.height,
    this.width,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final double height;
  final double width;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Container(
          height: sy(38),
          width: width,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: ColorUtil.primaryButtonColor,
            onPressed: onPressed,
            child: Text(
              text ?? 'No Text',
              style: TextStyle(
                color: ColorUtil.onboardBackground,
                fontSize: sy(10),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      },
    );
  }
}
