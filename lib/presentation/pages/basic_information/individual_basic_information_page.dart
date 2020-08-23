import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/style/textfield_theme.dart';
import 'package:radar_qrcode_flutter/presentation/pages/verification/verification_page.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/bar/custom_regular_app_bar.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/pages/mobile_status_margin_top.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/properties/shadow_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/header_text.dart';

class IndividualBasicInformationPage extends StatefulWidget {
  @override
  _IndividualBasicInformationPageState createState() =>
      _IndividualBasicInformationPageState();
}

class _IndividualBasicInformationPageState
    extends State<IndividualBasicInformationPage> {
  final double textFieldMargin = 10.0;

  PageController _topPageController;

  int _pageControllerIndex;

  @override
  initState() {
    super.initState();
    _pageControllerIndex = 0;
    _topPageController = PageController(initialPage: 0, viewportFraction: 1);
  }

  void _goToPage(int page) {
    setState(() {
      _pageControllerIndex = page;
      _topPageController.animateToPage(page,
          duration: Duration(milliseconds: 150), curve: Curves.decelerate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MobileStatusMarginTop(
      child: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _topPageController,
          children: [
            _basicInformationPage1(),
            _basicInformationPage2(),
            _verificationCodePage3(),
          ],
          onPageChanged: (int index) {},
        ),
      ),
    );
  }

  Widget _verificationCodePage3() {
    return CustomRegularAppBar(
      backgroundColor: Colors.transparent,
      onBackTap: () {
        _goToPage(_pageControllerIndex - 1);
      },
      body: VerificationPage(
        type: SelectedRegistrationType.Individual,
      ),
    );
  }

  Widget _basicInformationPage2() {
    return CustomRegularAppBar(
      backgroundColor: Colors.transparent,
      onBackTap: () {
        _goToPage(_pageControllerIndex - 1);
      },
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  child: HeaderText(
                    title: "Enter Basic Information",
                    fontSize: 22,
                    color: ColorUtil.primaryColor,
                  ),
                ),
                _buildCreatePINTextField(),
                _buildConfirmPINTextField(),
                _buildContactNumberTextField(),
                _buildAddressTextField()
              ],
            ),
            SizedBox(height: 30),
            _buildContinuePage2Button()
          ],
        ),
      ),
    );
  }

  Widget _basicInformationPage1() {
    return CustomRegularAppBar(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  child: HeaderText(
                    title: "Enter Basic Information",
                    fontSize: 22,
                    color: ColorUtil.primaryColor,
                  ),
                ),
                _buildFirstNameTextField(),
                _buildMiddleNameTextField(),
                _buildLastNameTextField(),
                _buildBirthdateTextField(),
                _buildGenderNameTextField()
              ],
            ),
            SizedBox(height: 30),
            _buildContinuePage1Button()
          ],
        ),
      ),
    );
  }

  Widget _buildCreatePINTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextFormField(
          obscureText: true,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration:
              TextFieldTheme.textfieldInputDecoration(hintText: "Create PIN"),
        ),
      ),
    );
  }

  Widget _buildConfirmPINTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextFormField(
          obscureText: true,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration:
              TextFieldTheme.textfieldInputDecoration(hintText: "Confirm PIN"),
        ),
      ),
    );
  }

  Widget _buildContactNumberTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextFormField(
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration: TextFieldTheme.textfieldInputDecoration(
              hintText: "Contact Number"),
        ),
      ),
    );
  }

  Widget _buildAddressTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextFormField(
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration:
              TextFieldTheme.textfieldInputDecoration(hintText: "Address"),
        ),
      ),
    );
  }

  Widget _buildGenderNameTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextField(
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration:
              TextFieldTheme.textfieldInputDecoration(hintText: "Gender"),
        ),
      ),
    );
  }

  Widget _buildFirstNameTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextField(
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration:
              TextFieldTheme.textfieldInputDecoration(hintText: "First Name"),
        ),
      ),
    );
  }

  Widget _buildMiddleNameTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextFormField(
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration:
              TextFieldTheme.textfieldInputDecoration(hintText: "Middle Name"),
        ),
      ),
    );
  }

  Widget _buildLastNameTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextFormField(
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration:
              TextFieldTheme.textfieldInputDecoration(hintText: "Last Name"),
        ),
      ),
    );
  }

  Widget _buildBirthdateTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextFormField(
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration:
              TextFieldTheme.textfieldInputDecoration(hintText: "Birth Date"),
        ),
      ),
    );
  }

  Widget _buildContinuePage1Button() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: PrimaryButton(
        text: "CONTINUE",
        fontSize: 14,
        onPressed: () {
          _goToPage(_pageControllerIndex + 1);
        },
      ),
    );
  }

  Widget _buildContinuePage2Button() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: PrimaryButton(
        text: "CONTINUE",
        fontSize: 14,
        onPressed: () {
          _goToPage(_pageControllerIndex + 1);
        },
      ),
    );
  }
}
