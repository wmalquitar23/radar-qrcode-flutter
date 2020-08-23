import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/string_util.dart';
import 'package:relative_scale/relative_scale.dart';

class NavigationItem extends StatelessWidget {
  const NavigationItem({
    Key key,
    @required this.iconAsset,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);

  final String iconAsset;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return FlatButton(
          onPressed: onPressed ?? () {},
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.symmetric(horizontal: sy(12), vertical: sy(10)),
          child: Row(
            children: [
              ExtendedImage.asset(
                '$navigationImages/$iconAsset',
                height: sy(36),
                width: sy(36),
              ),
              SizedBox(width: sx(18)),
              Text(
                title ?? 'Unknown',
                style: TextStyle(
                  fontSize: sy(14),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
