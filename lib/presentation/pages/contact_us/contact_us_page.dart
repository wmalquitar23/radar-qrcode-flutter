import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/contact_us/contact_us_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/bar/custom_regular_app_bar.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/pages/mobile_status_margin_top.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/description_text.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/header_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  // final List<bool> _selections = [true, false];
  bool _isEnglish = true;
  bool _isTagalog = false;

  void _onLoad() async {
    BlocProvider.of<ContactUsBloc>(context).add(
      GetRapidPassContact(),
    );
  }

  void _sendMessage(String mobileNumber) {
    final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: mobileNumber,
      queryParameters: {'sms': mobileNumber},
    );

    launch(smsLaunchUri.toString());
  }

  void _sendEmail(String emailAddress) {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: {'subject': 'Feedback/Concern'},
    );

    launch(_emailLaunchUri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MobileStatusMarginTop(
      child: CustomRegularAppBar(
        backgroundColor: Colors.transparent,
        title: "Contact Us",
        body: BlocBuilder<ContactUsBloc, ContactUsState>(
          builder: (context, state) {
            String mobileNumber;
            String emailAddress;

            if (state is ContactUsInitial) {
              _onLoad();
            }

            if (state is ContactUsInitial ||
                state is ContactUsGetDataInProgress) {
              return Container(
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
            }

            if (state is ContactUsGetDataDone) {
              mobileNumber = state.rapidPassContact.mobileNumber;
              emailAddress = state.rapidPassContact.emailAddress;
            }

            return Container(
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
                    title: _isEnglish
                        ? "Your feedback or concern is very important to us, so if you have any please contact us via phone or email given below."
                        : "Kung may concern o problima kayo sa inyong radar app tumawag lang sa aming numero or email na nasa baba.",
                    fontWeight: FontWeight.w500,
                    color: ColorUtil.primaryTextColor,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  _buildLanguageToggleButtons(),
                  SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DescriptionText(
                        title: "Contact Number:",
                        color: ColorUtil.primaryTextColor,
                        fontSize: 14,
                      ),
                      GestureDetector(
                        onTap: () => _sendMessage(mobileNumber),
                        child: DescriptionText(
                          title: mobileNumber,
                          color: ColorUtil.primaryColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(
                          thickness: 0.3,
                          color: ColorUtil.primarySubTextColor)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DescriptionText(
                        title: "Email:",
                        color: ColorUtil.primaryTextColor,
                        fontSize: 14,
                      ),
                      GestureDetector(
                        onTap: () => _sendEmail(emailAddress),
                        child: DescriptionText(
                          title: emailAddress,
                          color: ColorUtil.primaryColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  ToggleButtons _buildLanguageToggleButtons() {
    return ToggleButtons(
      constraints: BoxConstraints.tight(Size(55, 25)),
      children: [
        Text("English"),
        Text("Tagalog"),
      ],
      isSelected: [_isEnglish, _isTagalog],
      borderRadius: BorderRadius.circular(30.0),
      color: ColorUtil.primaryTextColor,
      borderColor: ColorUtil.primaryTextColor,
      selectedBorderColor: ColorUtil.primaryTextColor,
      fillColor: ColorUtil.primaryColor,
      selectedColor: ColorUtil.primaryBackgroundColor,
      onPressed: (int index) {
        setState(() {
          _isEnglish = !_isEnglish;
          _isTagalog = !_isTagalog;
        });
      },
    );
  }
}
