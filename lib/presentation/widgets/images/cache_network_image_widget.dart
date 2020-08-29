import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CacheNetworkImageWidget extends StatelessWidget {
  final String image;
  final double height;
  final double width;

  const CacheNetworkImageWidget({Key key, this.image, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(image);
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) {
        return Container(
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CupertinoActivityIndicator(),
            ));
      },
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => new Icon(Icons.error),
    );
  }
}
