import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key key,
    @required this.text,
    this.height,
    this.width,
    this.fontSize,
    this.radius,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final double height;
  final double width;
  final double fontSize;
  final double radius;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height ?? 50.0,
      width: this.width ?? double.infinity,
      child: OutlineButton(
        onPressed: onPressed ?? () {},
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(this.radius ?? 25),
        ),
        child: Text(
          this.text,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: this.fontSize ?? 14,
          ),
        ),
      ),
    );
  }
}
