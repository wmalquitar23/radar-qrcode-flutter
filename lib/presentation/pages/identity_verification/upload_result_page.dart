import 'package:flutter/material.dart';

import '../../../core/utils/color_util.dart';
import '../../../core/utils/routes/routes_list.dart';
import '../../widgets/buttons/primary_button_widget.dart';
import '../../widgets/pages/mobile_status_margin_top.dart';
import '../../widgets/texts/description_text.dart';
import '../../widgets/texts/header_text.dart';

class UploadResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MobileStatusMarginTop(
      child: Scaffold(
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
              'assets/images/undraw/id-card-with-check.png',
              width: 105,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            child: HeaderText(
              title: "Your document has been successfully uploaded for review",
              fontSize: 18,
              color: ColorUtil.primaryColor,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: DescriptionText(
              title:
                  "Your request is being reviewed and you should receive a reply as soon as possible 24-48hrs",
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
        text: "DONE",
        onPressed: () => Navigator.popUntil(
            context, ModalRoute.withName(INDIVIDUAL_HOME_ROUTE)),
      ),
    );
  }
}
