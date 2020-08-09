import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/description_text.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/header_text.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 30.0),
                child: Container(
                  height: 200,
                  child: Image.asset("assets/images/undraw/onboarding.png"),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: HeaderText(
                  title: "QR Code Scanner",
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: DescriptionText(
                  textAlign: TextAlign.center,
                  title:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt",
                ),
              ),
              PrimaryButton(
                text: "Next",
                fontSize: 14,
              )
            ],
          ),
        ),
      ),
    );
  }
}
