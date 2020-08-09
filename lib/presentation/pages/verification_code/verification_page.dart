import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/pages/mobile_status_margin_top.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/description_text.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/header_text.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  @override
  Widget build(BuildContext context) {
    var mediaQD = MediaQuery.of(context);
    var maxWidth = mediaQD.size.width;
    return MobileStatusMarginTop(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  child: HeaderText(
                    title: "Verification",
                    fontSize: 24,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30.0),
                  child: Container(
                    height: 175,
                    child: Image.asset(
                        "assets/images/undraw/verification_sms.png"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: HeaderText(
                    title: "Verify your number",
                    fontSize: 18,
                    color: ColorUtil.secondaryTextColor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15.0),
                  child: DescriptionText(
                    title: "4 digit code was sent to 09451096905",
                    color: ColorUtil.secondaryTextColor,
                  ),
                ),
                _buildCode(maxWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCode(maxWidth) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    _buildNumberContainer(),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                        thickness: 0.5, color: ColorUtil.primarySubTextColor),
                    _buildOtpKeyboard(maxWidth)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _otpKeyboardInputButton({String label, VoidCallback onPressed}) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        onTap: onPressed,
        borderRadius: new BorderRadius.circular(20.0),
        child: new Container(
          height: 40.0,
          width: 60.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: new Center(
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 30.0,
                color: ColorUtil.primaryTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _setCurrentDigit(int i, maxWidth) {
    setState(() {
      _currentDigit = i;
      if (_firstDigit == null) {
        _firstDigit = _currentDigit;
      } else if (_secondDigit == null) {
        _secondDigit = _currentDigit;
      } else if (_thirdDigit == null) {
        _thirdDigit = _currentDigit;
      } else if (_fourthDigit == null) {
        _fourthDigit = _currentDigit;

        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            radiusBorder = true;
          });
          Future.delayed(const Duration(milliseconds: 1000), () {
            Navigator.pushNamed(context, HOME_PAGE_ROUTE);
          });
        });
      }
    });
  }

  Widget _buildOtpKeyboard(maxWidth) {
    return Container(
        height: MediaQuery.of(context).size.width - 150,
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "1",
                      onPressed: () {
                        _setCurrentDigit(1, maxWidth);
                      }),
                  _otpKeyboardInputButton(
                      label: "2",
                      onPressed: () {
                        _setCurrentDigit(2, maxWidth);
                      }),
                  _otpKeyboardInputButton(
                      label: "3",
                      onPressed: () {
                        _setCurrentDigit(3, maxWidth);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "4",
                      onPressed: () {
                        _setCurrentDigit(4, maxWidth);
                      }),
                  _otpKeyboardInputButton(
                      label: "5",
                      onPressed: () {
                        _setCurrentDigit(5, maxWidth);
                      }),
                  _otpKeyboardInputButton(
                      label: "6",
                      onPressed: () {
                        _setCurrentDigit(6, maxWidth);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "7",
                      onPressed: () {
                        _setCurrentDigit(7, maxWidth);
                      }),
                  _otpKeyboardInputButton(
                      label: "8",
                      onPressed: () {
                        _setCurrentDigit(8, maxWidth);
                      }),
                  _otpKeyboardInputButton(
                      label: "9",
                      onPressed: () {
                        _setCurrentDigit(9, maxWidth);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new SizedBox(
                    width: 60.0,
                  ),
                  _otpKeyboardInputButton(
                      label: "0",
                      onPressed: () {
                        _setCurrentDigit(0, maxWidth);
                      }),
                  _otpKeyboardActionButton(
                      label: new Icon(
                        Icons.backspace,
                        color: ColorUtil.primaryTextColor,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_fourthDigit != null) {
                            _fourthDigit = null;
                          } else if (_thirdDigit != null) {
                            _thirdDigit = null;
                          } else if (_secondDigit != null) {
                            _secondDigit = null;
                          } else if (_firstDigit != null) {
                            _firstDigit = null;
                          }
                        });
                      }),
                ],
              ),
            ),
          ],
        ));
  }

  _otpKeyboardActionButton({Widget label, VoidCallback onPressed}) {
    return new InkWell(
      onTap: onPressed,
      borderRadius: new BorderRadius.circular(40.0),
      child: new Container(
        height: 40.0,
        width: 60.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: new Center(
          child: label,
        ),
      ),
    );
  }

  bool radiusBorder = false;

  int _currentDigit, _firstDigit, _secondDigit, _thirdDigit, _fourthDigit;

  Widget _buildOtpTextField(int digit) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 55,
      width: 55,
      decoration: BoxDecoration(
          color: Colors.white,
          border: radiusBorder
              ? Border.all(width: 2.0, color: ColorUtil.primaryColor)
              : Border.all(color: ColorUtil.primaryTextColor),
          borderRadius: BorderRadius.circular(10.0)),
      child: Center(
        child: Text(
          digit != null ? digit.toString() : "",
          textAlign: TextAlign.center,
          style:
              TextStyle(fontSize: 30, color: ColorUtil.verifyNumberBlackColor),
        ),
      ),
    );
  }

  Widget _buildNumberContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildOtpTextField(_firstDigit),
            _buildOtpTextField(_secondDigit),
            _buildOtpTextField(_thirdDigit),
            _buildOtpTextField(_fourthDigit),
          ],
        ),
      ],
    );
  }
}
