import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';

class TextFieldTheme {
  static InputDecoration textfieldInputDecoration({String hintText}) {
    return InputDecoration(
      filled: true,
      contentPadding: EdgeInsets.only(left: 10.0),
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
}
