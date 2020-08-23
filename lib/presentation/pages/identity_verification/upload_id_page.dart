import 'package:flutter/material.dart';

import '../../../core/utils/color_util.dart';
import '../../../core/utils/routes/routes_list.dart';
import '../../widgets/bar/custom_regular_app_bar.dart';
import '../../widgets/buttons/primary_button_widget.dart';
import '../../widgets/buttons/secondary_button.dart';
import '../../widgets/pages/mobile_status_margin_top.dart';
import '../../widgets/texts/header_text.dart';

class UploadIDPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MobileStatusMarginTop(
      child: CustomRegularAppBar(
        backgroundColor: Colors.transparent,
        title: "Upload ID",
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildIDSection(),
              _buildTakeAnotherPhotoButton(context),
              _buildGuidelines(),
              _buildUploadButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIDSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFD6D6D6)),
        color: Color(0xFFEFF1F3),
      ),
      child: Image.asset(
        'assets/images/undraw/sample-id.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildTakeAnotherPhotoButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: SecondaryButton(
        text: "Take another picture",
        fontSize: 12,
        height: 30,
        width: 170,
        radius: 12,
        onPressed: () =>
            Navigator.of(context).pushNamed(DUMMY_CAMERA_VIEW_ROUTE),
      ),
    );
  }

  Widget _buildGuidelines() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: <Widget>[
          HeaderText(
            title: "Before uploading your ID image, check for the following:",
            fontSize: 18,
          ),
          SizedBox(height: 10),
          _buildChecklistItem("The photo is not blurry"),
          _buildChecklistItem("The image hasn't been manupulated in any way"),
          _buildChecklistItem(
              "There is a border area around your ID and all four corners should be visible"),
        ],
      ),
    );
  }

  Container _buildChecklistItem(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Icon(
              Icons.check_circle,
              color: ColorUtil.primaryColor,
              size: 12,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
              child: Text(
            text,
            style: TextStyle(fontSize: 14),
          )),
        ],
      ),
    );
  }

  Widget _buildUploadButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 40),
      child: PrimaryButton(
          text: "UPLOAD",
          onPressed: () =>
              Navigator.of(context).pushNamed(UPLOAD_ID_RESULT_ROUTE)),
    );
  }
}
