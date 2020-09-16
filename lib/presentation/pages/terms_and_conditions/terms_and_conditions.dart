import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/strings/terms_and_conditions_string.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/bar/custom_regular_app_bar.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/secondary_button.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/pages/mobile_status_margin_top.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/description_text.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/header_text.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/paragraph_text.dart';

class TermsAndConditionsPage extends StatefulWidget {
  final bool isAgree;

  const TermsAndConditionsPage({Key key, @required this.isAgree}) : super(key: key);
  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  ScrollController _controller;
  bool hasScrolledAtBottom;
  bool _agreementCheckBox;

  @override
  void initState() {
    hasScrolledAtBottom = widget.isAgree;
    _agreementCheckBox = widget.isAgree;
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        if (_agreementCheckBox) {
          hasScrolledAtBottom = true;
        } else {
          hasScrolledAtBottom = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MobileStatusMarginTop(
      child: CustomRegularAppBar(
        isContainerScrollable: false,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: _controller,
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.fromLTRB(
                    0.0, 0.0, 15.0, MediaQuery.of(context).size.height * 0.20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeaderText(
                            title: "TERMS AND CONDITION",
                            textAlign: TextAlign.left,
                            fontWeight: FontWeight.w500,
                            color: ColorUtil.primaryColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ParagraphText(
                            label: DEFINITIONS.label,
                            content: DEFINITIONS.content,
                          ),
                          ParagraphText(
                            label: ACCOUNT.label,
                            content: ACCOUNT.content,
                          ),
                          ParagraphText(
                            label: LICENSETOUSE.label,
                            content: LICENSETOUSE.content,
                          ),
                          ParagraphText(
                            label: PROHIBITEDUSES.label,
                            content: PROHIBITEDUSES.content,
                          ),
                          ParagraphText(
                            label: INTELLECTUALPROPERTYRIGHTS.label,
                            content: INTELLECTUALPROPERTYRIGHTS.content,
                          ),
                          ParagraphText(
                            label: SUSPENSIONTERMINATIONOFACCOUNT.label,
                            content: SUSPENSIONTERMINATIONOFACCOUNT.content,
                          ),
                          ParagraphText(
                            label: MODIFICATIONOFTERMS.label,
                            content: MODIFICATIONOFTERMS.content,
                          ),
                          ParagraphText(
                            label: DISCLAIMERSANDWARRANTIES.label,
                            content: DISCLAIMERSANDWARRANTIES.content,
                          ),
                          ParagraphText(
                            label: LIMITATIONOFLIABILITY.label,
                            content: LIMITATIONOFLIABILITY.content,
                          ),
                          ParagraphText(
                            label: JURISDICTION.label,
                            content: JURISDICTION.content,
                          ),
                          ParagraphText(
                            label: PRIVACYNOTICE.label,
                            content: PRIVACYNOTICE.content,
                          ),
                          ParagraphText(
                            label: SEVERABILITY.label,
                            content: SEVERABILITY.content,
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          HeaderText(
                            title: "PRIVACY POLICY",
                            textAlign: TextAlign.left,
                            fontWeight: FontWeight.w500,
                            color: ColorUtil.primaryColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ParagraphText(
                            label: PRIVACYNOTICELABEL.label,
                          ),
                          ParagraphText(
                            label: PRIVACYSTATEMENT.label,
                            content: PRIVACYSTATEMENT.content,
                          ),
                          ParagraphText(
                            label: SCOPE.label,
                            content: SCOPE.content,
                          ),
                          ParagraphText(
                            label: COLLECTION_AND_USE_OF_PERSONAL_DATA.label,
                            content:
                                COLLECTION_AND_USE_OF_PERSONAL_DATA.content,
                          ),
                          ParagraphText(
                            label: DISCLOSURES_OF_INFORMATION.label,
                            content: DISCLOSURES_OF_INFORMATION.content,
                          ),
                          ParagraphText(
                            label: PERSONAL_DATA_SECURITY_POLICY.label,
                            content: PERSONAL_DATA_SECURITY_POLICY.content,
                          ),
                          ParagraphText(
                            label: PARTICIPATION_OF_DATA_SUBJECTS.label,
                            content: PARTICIPATION_OF_DATA_SUBJECTS.content,
                          ),
                          ParagraphText(
                            label: DATA_PROTECTION_OFFICER.label,
                            content: DATA_PROTECTION_OFFICER.content,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _agreementCheckBox,
                          onChanged: (value) {
                            setState(() {
                              _agreementCheckBox = value;
                              _scrollListener();
                            });
                          },
                        ),
                        Flexible(
                          child: DescriptionText(
                            textAlign: TextAlign.start,
                            title:
                                "Notify me of your future updates, promos and services.",
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: ColorUtil.primaryTextColor,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: DescriptionText(
                        textAlign: TextAlign.start,
                        title:
                            "By clicking I Accept, the USER agrees to the Terms and Conditions and Privacy Policy of this Agreement.",
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: ColorUtil.primaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              child: new Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.20,
                  decoration: BoxDecoration(
                    color: ColorUtil.primaryBackgroundColor,
                    gradient: LinearGradient(
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.0, 0.5),
                      colors: [
                        Colors.white.withOpacity(0.0),
                        ColorUtil.primaryBackgroundColor,
                      ],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: SecondaryButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                height: 45,
                                text: 'Decline',
                                fontSize: 12,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: PrimaryButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                height: 45,
                                text: 'I accept',
                                fontSize: 12,
                                color: hasScrolledAtBottom
                                    ? ColorUtil.primaryColor
                                    : Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
