import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';

class CacheImage extends StatelessWidget {
  final String image;
  final Widget child;
  final double size;

  CacheImage({
    this.image,
    this.child,
    this.size,
  });
  @override
  Widget build(BuildContext context) {
    print(image);
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) => child,
      placeholder: (context, url) {
        return Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorUtil.primarySubTextColor,
          ),
          child: Center(
            child: CupertinoActivityIndicator(),
          ),
        );
      },
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
          child: Center(
            child: new Icon(Icons.error),
          )),
    );
  }
}
