import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/images/cache_image_widget.dart';

class CircleImage extends StatelessWidget {
  final double size;
  final String imageUrl;
  final Function onClick;
  final bool fromNetwork;
  final Border border;

  const CircleImage({
    Key key,
    @required this.size,
    @required this.imageUrl,
    this.onClick,
    this.border,
    this.fromNetwork = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: fromNetwork
          ? CacheImage(
              image: imageUrl,
              size: size,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: border,
                    image: DecorationImage(
                        image: fromNetwork
                            ? CachedNetworkImageProvider(imageUrl)
                            : AssetImage(imageUrl),
                        fit: BoxFit.cover)),
                width: size,
                height: size,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: fromNetwork
                          ? NetworkImage(imageUrl)
                          : AssetImage(imageUrl),
                      fit: BoxFit.cover)),
              width: size,
              height: size,
            ),
    );
  }
}
