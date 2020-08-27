import 'package:flutter/material.dart';

class ToastUtil {
  static void showToast(BuildContext context, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final scaffold = Scaffold.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: Text(message ?? ""),
          action: SnackBarAction(
            label: 'HIDE',
            onPressed: scaffold.hideCurrentSnackBar,
          ),
        ),
      );
    });
  }
}
