import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:radar_qrcode_flutter/core/utils/image/image.utils.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';

import '../../../core/utils/color_util.dart';
import '../../widgets/bar/custom_regular_app_bar_v2.dart';
import '../../widgets/buttons/primary_button_widget.dart';
import '../../widgets/pages/mobile_status_margin_top.dart';
import '../../widgets/texts/description_text.dart';
import '../../widgets/texts/header_text.dart';

class IdentityVerificationPage extends StatefulWidget {
  @override
  _IdentityVerificationPageState createState() =>
      _IdentityVerificationPageState();
}

class _IdentityVerificationPageState extends State<IdentityVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return MobileStatusMarginTop(
      child: CustomRegularAppBarV2(
        backgroundColor: Colors.transparent,
        title: "Identity Verification",
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildMainContent(),
              _buildGetStartedButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset(
              'assets/images/undraw/id-card.png',
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            child: HeaderText(
              title: "Submit your ID",
              fontSize: 18,
              color: ColorUtil.primaryColor,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: DescriptionText(
              title:
                  "In order to complete the verification, please take a picture of your valid government or company ID card. All data will be encrypted and securely processed.",
              color: ColorUtil.primaryTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 40),
      child: PrimaryButton(
        text: "GET STARTED",
        onPressed: () {
          uploadID();
        },
      ),
    );
  }

  void uploadID() {
    ImageUtils.pickImage(
      context,
      (File file) async {
        File croppedFile = await ImageCropper.cropImage(
            sourcePath: file.path,
            cropStyle: CropStyle.rectangle,
            aspectRatioPresets: [
              CropAspectRatioPreset.ratio7x5,
            ],
            androidUiSettings: AndroidUiSettings(
                toolbarTitle: "Select Verification ID",
                hideBottomControls: true,
                showCropGrid: true,
                toolbarColor: ColorUtil.primaryColor,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.ratio7x5,
                lockAspectRatio: true),
            iosUiSettings: IOSUiSettings(
                minimumAspectRatio: 1.0,
                aspectRatioLockEnabled: true,
                aspectRatioPickerButtonHidden: true,
                title: "Select Verification ID"));

        if (croppedFile != null) {
          Navigator.pushNamed(context, UPLOAD_ID_ROUTE, arguments: croppedFile);
        }
      },
      maxWidth: 1024,
      maxHeight: 512,
    );
  }
}
