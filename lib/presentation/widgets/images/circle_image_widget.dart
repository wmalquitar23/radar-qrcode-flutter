import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final double size;
  final String imageUrl;
  final Function onClick;
  final bool fromNetwork;

  const CircleImage(
      {Key key,
      @required this.size,
      @required this.imageUrl,
      this.onClick,
      this.fromNetwork = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image:
                    fromNetwork ? NetworkImage(imageUrl) : AssetImage(imageUrl),
                fit: BoxFit.fill)),
        width: size,
        height: size,
      ),
    );
  }
}
