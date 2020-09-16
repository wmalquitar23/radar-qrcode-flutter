import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:radar_qrcode_flutter/core/utils/style/textfield_theme.dart';
import 'package:radar_qrcode_flutter/core/utils/toasts/toast_util.dart';
import 'package:radar_qrcode_flutter/data/models/address/barangay_model.dart';
import 'package:radar_qrcode_flutter/data/models/address/city_model.dart';
import 'package:radar_qrcode_flutter/data/models/address/province_model.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/establishment_signup/establishment_basic_information_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/pages/basic_information/address/address_widget.dart';
import 'package:radar_qrcode_flutter/presentation/pages/terms_and_conditions/terms_and_conditions.dart';
import 'package:radar_qrcode_flutter/presentation/pages/verification/verification_page.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/bar/custom_regular_app_bar.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/pages/mobile_status_margin_top.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/properties/shadow_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/header_text.dart';

class EstablishmentBasicInformationPage extends StatefulWidget {
  @override
  _EstablishmentBasicInformationPageState createState() =>
      _EstablishmentBasicInformationPageState();
}

class _EstablishmentBasicInformationPageState
    extends State<EstablishmentBasicInformationPage> {
  final double textFieldMargin = 10.0;

  PageController _topPageController;

  int _pageControllerIndex;

  TextEditingController _establishmentNameController = TextEditingController();
  TextEditingController _pinController = TextEditingController();
  TextEditingController _confirmPinController = TextEditingController();
  TextEditingController _contactNumberController = TextEditingController();
  TextEditingController _streetHouseNumController = TextEditingController();

  Province _selectedProvince;
  City _selectedCity;
  Barangay _selectedBarangay;

  bool _pinMatched = true;
  bool _contactNumberIsValid = false;
  bool _basicInfoIsValid = false;
  bool _agreementCheckBox = false;

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

  void _validatePIN() {
    final pinMatched = _pinController.text == _confirmPinController.text;
    if (_pinMatched != pinMatched) {
      setState(() {
        _pinMatched = pinMatched;
      });
    }
  }

  bool _checkValidityBasicInfo() {
    bool fieldsNotEmpty = false;
    bool isPinConfirmed = false;

    int changeCount = 0;
    changeCount += _establishmentNameController.text.isNotEmpty ? 1 : 0;
    changeCount += _pinController.text.isNotEmpty ? 1 : 0;
    changeCount += _confirmPinController.text.isNotEmpty ? 1 : 0;
    changeCount += _contactNumberController.text.isNotEmpty ? 1 : 0;

    if (changeCount == 4) {
      fieldsNotEmpty = true;
    }

    if (_pinController.text == _confirmPinController.text) {
      isPinConfirmed = true;
    }

    return (fieldsNotEmpty &&
        isPinConfirmed &&
        _contactNumberIsValid &&
        _agreementCheckBox &&
        _checkAddress());
  }

  bool _checkAddress() {
    return (_selectedProvince != null &&
        _selectedCity != null &&
        _selectedBarangay != null);
  }

  void _onChangeValidityBasicInfo() {
    final bool isValid = _checkValidityBasicInfo();
    if (_basicInfoIsValid != isValid) {
      setState(() {
        _basicInfoIsValid = isValid;
      });
    }
  }

  void _validateContactNumber() {
    BlocProvider.of<EstablishmentBasicInformationBloc>(context).add(
      ValidateContactNumber(
        contactNumber: _contactNumberController.text,
      ),
    );
  }

  void _onRegisterPressed() async {
    BlocProvider.of<EstablishmentBasicInformationBloc>(context).add(
      RegisterPressed(
        establishmentName: _establishmentNameController.text,
        pin: _pinController.text,
        contactNumber: _contactNumberController.text,
      ),
    );
  }

  void selectProvinceCallback(Province selectedProvince) {
    _selectedProvince = selectedProvince;
    _onChangeValidityBasicInfo();
  }

  void selectCityCallback(City selectedCity) {
    _selectedCity = selectedCity;
    _onChangeValidityBasicInfo();
  }

  void selectBarangayCallback(Barangay selectedBarangay) {
    _selectedBarangay = selectedBarangay;
    _onChangeValidityBasicInfo();
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
      body: VerificationPage(),
    );
  }

  Widget _basicInformationPage1() {
    return CustomRegularAppBar(
      backgroundColor: Colors.transparent,
      body: BlocConsumer<EstablishmentBasicInformationBloc,
          EstablishmentBasicInformationState>(
        listener: (context, state) {
          if (state is RegisterDone) {
            Navigator.pushNamed(
              context,
              VERIFICATION_CODE_ROUTE,
              arguments: _contactNumberController.text,
            );
          }
          if (state is RegisterFailure) {
            ToastUtil.showToast(context, state.error);
          }
        },
        builder: (context, state) {
          return Container(
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
                    _buildEstablishmentNameTextField(),
                    _buildCreatePINTextField(),
                    _buildConfirmPINTextField(),
                    _buildContactNumberTextField(),
                    AddressWidget(
                      selectProvinceCallback: (selectedProvince) =>
                          selectProvinceCallback(selectedProvince),
                      selectCityCallback: (selectedCity) =>
                          selectCityCallback(selectedCity),
                      selectBarangayCallback: (selectedBarangay) =>
                          selectBarangayCallback(selectedBarangay),
                    ),
                    _buildStreetHouseNumTextField(),
                    _buildAgreementLabel(),
                  ],
                ),
                SizedBox(height: 30),
                _buildContinuePage1Button(state)
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEstablishmentNameTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextField(
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration: TextFieldTheme.textfieldInputDecoration(
              hintText: "Establishment Name"),
          controller: _establishmentNameController,
          onChanged: (value) {
            _onChangeValidityBasicInfo();
          },
        ),
      ),
    );
  }

  Widget _buildCreatePINTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextFormField(
          maxLength: 4,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
          obscureText: true,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration:
              TextFieldTheme.textfieldInputDecoration(hintText: "Create PIN"),
          controller: _pinController,
          onChanged: (value) {
            _validatePIN();
            _onChangeValidityBasicInfo();
          },
        ),
      ),
    );
  }

  Widget _buildConfirmPINTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextFormField(
          maxLength: 4,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
          obscureText: true,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration: TextFieldTheme.textfieldInputDecoration(
            hintText: "Confirm PIN",
            errorText: _pinMatched ? null : "PIN does not match.",
          ),
          controller: _confirmPinController,
          onChanged: (value) {
            _validatePIN();
            _onChangeValidityBasicInfo();
          },
        ),
      ),
    );
  }

  Widget _buildContactNumberTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: BlocConsumer<EstablishmentBasicInformationBloc,
            EstablishmentBasicInformationState>(
          listenWhen: (previousState, currentState) =>
              currentState is ContactNumberState,
          listener: (context, state) {
            if (state is ContactNumberValidationFailure) {
              ToastUtil.showToast(context, state.error);
            }

            _contactNumberIsValid =
                state is ContactNumberIsValid ? true : false;
            _onChangeValidityBasicInfo();
          },
          buildWhen: (previousState, currentState) =>
              currentState is ContactNumberState &&
              previousState != currentState,
          builder: (context, state) {
            Widget suffixIcon;

            if (state is ContactNumberValidationInProgress) {
              suffixIcon = _buildValidationInProgressSufficIcon();
            } else if (state is ContactNumberIsValid) {
              suffixIcon = _buildvalidSuffixIcon();
            } else if (state is ContactNumberIsInvalid &&
                state.invalidType == 1) {
              suffixIcon = _buildInvalidSuffixIcon();
            }

            return TextFormField(
              maxLength: 10,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
              decoration: TextFieldTheme.textfieldInputDecoration(
                hintText: "9XX-XXX-XXXX",
                prefix: "+63",
                suffix: suffixIcon,
              ),
              controller: _contactNumberController,
              autovalidate: true,
              validator: (value) {
                if (state is ContactNumberIsInvalid && value.isNotEmpty) {
                  return state.message;
                }
                return null;
              },
              onChanged: (value) {
                _validateContactNumber();
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildInvalidSuffixIcon() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Icon(
        Icons.info_outline,
        color: Colors.red,
      ),
    );
  }

  Widget _buildvalidSuffixIcon() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Icon(
        Icons.check_circle_outline,
        color: Colors.green,
      ),
    );
  }

  Widget _buildValidationInProgressSufficIcon() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: CupertinoActivityIndicator(),
    );
  }

  Widget _buildStreetHouseNumTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextFormField(
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration: TextFieldTheme.textfieldInputDecoration(
              hintText: "Street/House No."),
          controller: _streetHouseNumController,
          onChanged: (value) {
            _onChangeValidityBasicInfo();
          },
        ),
      ),
    );
  }

  Widget _buildAgreementLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: Row(
        children: <Widget>[
          Checkbox(
            value: _agreementCheckBox,
            onChanged: (value) async {
              await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (context) => TermsAndConditionsPage(
                    isAgree: _agreementCheckBox,
                  ),
                ),
              ).then((value) {
                setState(() {
                  _agreementCheckBox = value;
                });
              });
              _onChangeValidityBasicInfo();
            },
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Text(
                  "I have read and agree to the ",
                  style: TextStyle(fontSize: 11),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                GestureDetector(
                  onTap: () async {
                    await Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TermsAndConditionsPage(
                          isAgree: _agreementCheckBox,
                        ),
                      ),
                    ).then((value) {
                      setState(() {
                        _agreementCheckBox = value;
                      });
                    });
                    _onChangeValidityBasicInfo();
                  },
                  child: Text(
                    "Terms & Conditions",
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xff0367B2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinuePage1Button(state) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: PrimaryButton(
        text: "CONTINUE",
        fontSize: 14,
        isLoading: state is RegisterProgress ? true : false,
        color: _basicInfoIsValid ? ColorUtil.primaryColor : Colors.grey,
        onPressed: _basicInfoIsValid ? () => _onRegisterPressed() : null,
      ),
    );
  }
}
