import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';

class TextFieldTheme {
  static InputDecoration textfieldInputDecoration({String hintText}) {
    return InputDecoration(
      filled: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      hintText: hintText ?? "",
      hintStyle: TextStyle(color: ColorUtil.primarySubTextColor),
      fillColor: ColorUtil.primaryBackgroundColor,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 1),
        borderRadius: new BorderRadius.circular(15.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorUtil.primaryColor, width: 2),
        borderRadius: new BorderRadius.circular(15.0),
      ),
    );
  }

  static textAreaInputDecoration({String hintText}) {
    return InputDecoration(
      filled: true,
      contentPadding: EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0),
      hintText: hintText ?? "",
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorUtil.primarySubTextColor, width: 1),
        borderRadius: new BorderRadius.circular(15.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorUtil.primaryColor, width: 2),
        borderRadius: new BorderRadius.circular(15.0),
      ),
    );
  }

  static ThemeData get primaryTextFieldStyle {
    return ThemeData(
        errorColor: Colors.red,
        hintColor: ColorUtil.primarySubTextColor,
        textTheme: TextTheme(
          subtitle1: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: ColorUtil.primaryTextColor,
          ),
        ),
        cursorColor: Colors.white70,
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(vertical: 15),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white54),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ColorUtil.primaryTextColor,
              style: BorderStyle.solid,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ColorUtil.primaryTextColor,
              style: BorderStyle.solid,
            ),
          ),
        ));
  }
}
