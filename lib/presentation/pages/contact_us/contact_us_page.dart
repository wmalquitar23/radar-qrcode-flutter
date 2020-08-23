import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/bar/custom_regular_app_bar.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/pages/mobile_status_margin_top.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/description_text.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/header_text.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return MobileStatusMarginTop(
      child: CustomRegularAppBar(
        backgroundColor: Colors.transparent,
        title: "Contact Us",
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: ExtendedImage.asset(
                  'assets/images/app/logo-black.png',
                  width: 110,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              HeaderText(
                title: "Get in touch with us",
                color: ColorUtil.primaryColor,
              ),
              SizedBox(
                height: 10.0,
              ),
              DescriptionText(
                title:
                    "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore.",
                fontWeight: FontWeight.w500,
                color: ColorUtil.primaryTextColor,
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DescriptionText(
                    title: "Contact Number:",
                    color: ColorUtil.primaryTextColor,
                    fontSize: 14,
                  ),
                  DescriptionText(
                    title: "09451096905",
                    color: ColorUtil.primaryColor,
                    fontSize: 14,
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(
                      thickness: 0.3, color: ColorUtil.primarySubTextColor)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DescriptionText(
                    title: "Email:",
                    color: ColorUtil.primaryTextColor,
                    fontSize: 14,
                  ),
                  DescriptionText(
                    title: "info@abc.com",
                    color: ColorUtil.primaryColor,
                    fontSize: 14,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
