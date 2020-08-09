import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/images/circle_image_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/pages/mobile_status_margin_top.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/description_text.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/header_text.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/label_text.dart';

class GetStartedPage extends StatefulWidget {
  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    return MobileStatusMarginTop(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 15.0),
                child: HeaderText(
                  title: "Let\'s Get Started!",
                  fontSize: 24,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 40.0),
                child: LabelText(
                  fontSize: 16.0,
                  title: "Register As",
                  color: ColorUtil.primarySubTextColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      CircleImage(
                        size: 125.0,
                        imageUrl: "assets/images/undraw/individual.png",
                        fromNetwork: false,
                      ),
                      SizedBox(
                        height: 23.0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: LabelText(title: "Individual"),
                      ),
                      Container(
                        width: 125,
                        child: DescriptionText(
                            title:
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      CircleImage(
                        size: 125.0,
                        imageUrl: "assets/images/undraw/establishment.png",
                        fromNetwork: false,
                      ),
                      SizedBox(
                        height: 23.0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: LabelText(title: "Establishment"),
                      ),
                      Container(
                        width: 125,
                        child: DescriptionText(
                            title:
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              PrimaryButton(
                text: "Register",
                fontSize: 14,
                onPressed: () {
                  Navigator.pushNamed(context, BASIC_INFORMATION_ROUTE);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
