import 'package:flutter/material.dart';

class ShadowWidget extends StatelessWidget {
  final Widget child;
  final bool isSmall;

  const ShadowWidget({Key key, this.child, this.isSmall = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          isSmall
              ? BoxShadow(
                  color: Colors.grey.withOpacity(0.05),
                  spreadRadius: 0.2,
                  blurRadius: 5,
                  offset: Offset(0, 4), // changes position of shadow
                )
              : BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 4), // changes position of shadow
                ),
        ],
      ),
      child: child,
    );
  }
}
