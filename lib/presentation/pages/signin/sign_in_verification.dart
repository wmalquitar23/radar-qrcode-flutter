import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar_qrcode_flutter/core/utils/toasts/toast_util.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/sign_in_verification/sign_in_verification_bloc.dart';

import '../../widgets/bar/custom_regular_app_bar.dart';
import '../../widgets/pages/mobile_status_margin_top.dart';
import '../../../core/utils/color_util.dart';
import '../../widgets/texts/header_text.dart';
import '../../widgets/texts/description_text.dart';
import '../../widgets/buttons/primary_button_widget.dart';
import '../../widgets/properties/shadow_widget.dart';

class SignInVerificationPage extends StatefulWidget {
  const SignInVerificationPage({Key key, this.contactNumber}) : super(key: key);

  final String contactNumber;

  @override
  _SignInVerificationPageState createState() => _SignInVerificationPageState();
}

class _SignInVerificationPageState extends State<SignInVerificationPage> {
  SignInVerificationBloc _bloc;

  @override
  void initState() {
    _bloc = SignInVerificationBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQD = MediaQuery.of(context);
    var maxWidth = mediaQD.size.width;
    return MobileStatusMarginTop(
      child: CustomRegularAppBar(
        backgroundColor: Colors.transparent,
        title: "Verification",
        body: Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: HeaderText(
                  title: "Enter PIN",
                  fontSize: 24,
                  color: ColorUtil.primaryColor,
                ),
              ),
              Container(
                child: DescriptionText(
                  title: "Enter your 4-digit PIN",
                  color: ColorUtil.secondaryTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              _buildCode(maxWidth),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  Widget _buildCode(maxWidth) {
    return BlocConsumer<SignInVerificationBloc, SignInVerificationState>(
      listener: (context, state) {
        if (state is SignInFailure) {
          ToastUtil.showToast(context, state.error);
        }
      },
      cubit: _bloc,
      builder: (BuildContext context, SignInVerificationState state) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        _buildNumberContainer(),
                        SizedBox(
                          height: 70,
                        ),
                        PrimaryButton(
                            isLoading: state is ButtonLoading,
                            text: "CONTINUE",
                            onPressed: () {
                              if (_fourthDigit == null) {
                                return;
                              }

                              _bloc.onSignIn(widget.contactNumber,
                                  "$_firstDigit$_secondDigit$_thirdDigit$_fourthDigit");
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                            thickness: 0.5,
                            color: ColorUtil.primarySubTextColor),
                        _buildOtpKeyboard(maxWidth)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
    return digit != null
        ? _otpField(digit)
        : ShadowWidget(
            isSmall: true,
            child: _otpField(digit),
          );
  }

  Widget _otpField(int digit) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 55,
      width: 55,
      decoration: BoxDecoration(
          color: digit == null ? Colors.white : ColorUtil.primaryColor,
          borderRadius: BorderRadius.circular(20.0)),
      child: Center(
        child: Text(
          digit != null ? digit.toString() : "",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              color: ColorUtil.primaryBackgroundColor,
              fontWeight: FontWeight.w600),
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
            _buildOtpTextField(_fourthDigit)
          ],
        ),
      ],
    );
  }
}
