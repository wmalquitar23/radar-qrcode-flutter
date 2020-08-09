import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
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
      child: FlatButton(
        onPressed: onPressed ?? () {},
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(this.radius ?? 25)),
        color: Theme.of(context).primaryColor,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: this.fontSize,
          ),
        ),
      ),
    );
  }
}
