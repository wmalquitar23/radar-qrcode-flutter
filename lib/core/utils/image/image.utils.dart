import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'platform_bottom_sheet.dart';

class ImageUtils {
  static Future<void> pickImage(
    BuildContext context,
    Function(File file) onFilePicked, {
    double maxWidth,
    double maxHeight,
  }) async {
    int imageQuality = 90;

    PlatformBottomSheet.showBottomSheet(
      context,
      [
        ActionSheet("Gallery", () async {
          PickedFile picker = await ImagePicker().getImage(
              source: ImageSource.gallery,
              imageQuality: imageQuality,
              maxHeight: maxHeight,
              maxWidth: maxWidth);
          onFilePicked(File(picker.path));
        }, leading: Icon(Icons.photo_library), popAutomatically: true),
        ActionSheet("Camera", () async {
          PickedFile picker = await ImagePicker().getImage(
              source: ImageSource.gallery,
              imageQuality: imageQuality,
              maxHeight: maxHeight,
              maxWidth: maxWidth);
          onFilePicked(File(picker.path));
        }, leading: Icon(Icons.camera), popAutomatically: true),
      ],
    );
  }
}
