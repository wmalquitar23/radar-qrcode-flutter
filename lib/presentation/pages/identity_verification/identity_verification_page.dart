import 'package:flutter/material.dart';

import '../../../core/utils/color_util.dart';
import '../../../core/utils/routes/routes_list.dart';
import '../../widgets/bar/custom_regular_app_bar_v2.dart';
import '../../widgets/buttons/primary_button_widget.dart';
import '../../widgets/pages/mobile_status_margin_top.dart';
import '../../widgets/texts/description_text.dart';
import '../../widgets/texts/header_text.dart';

class IdentityVerificationPage extends StatelessWidget {
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
        onPressed: () => Navigator.of(context).pushNamed(DUMMY_CAMERA_VIEW_ROUTE),
      ),
    );
  }
}
