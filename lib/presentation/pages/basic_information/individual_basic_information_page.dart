import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:radar_qrcode_flutter/core/utils/string_utils.dart';
import 'package:radar_qrcode_flutter/core/utils/style/textfield_theme.dart';
import 'package:radar_qrcode_flutter/core/utils/toasts/toast_util.dart';
import 'package:radar_qrcode_flutter/data/models/address/barangay_model.dart';
import 'package:radar_qrcode_flutter/data/models/address/city_model.dart';
import 'package:radar_qrcode_flutter/data/models/address/province_model.dart';
import 'package:radar_qrcode_flutter/data/models/address/user_address_model.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/individual_signup/individual_basic_information_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/pages/basic_information/address/address_widget.dart';
import 'package:radar_qrcode_flutter/presentation/pages/terms_and_conditions/terms_and_conditions.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/bar/custom_regular_app_bar.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/dialogs/gender_dialog.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/dialogs/suffix_picker_dialog.dart';
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

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _middleNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _suffixController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _pinController = TextEditingController();
  TextEditingController _confirmPinController = TextEditingController();
  TextEditingController _contactNumberController = TextEditingController();
  TextEditingController _streetHouseNumController = TextEditingController();
  TextEditingController _individualEmailController = TextEditingController();

  Province _selectedProvince;
  City _selectedCity;
  Barangay _selectedBarangay;

  int _pageControllerIndex;
  String gender;
  Gender _genderValue;

  DateTime _datepicked;
  DateTime _date = DateTime.now();

  bool _basicInfo1IsValid = false;
  bool _basicInfo2IsValid = false;
  bool _pinMatched = true;
  bool _contactNumberIsValid = false;
  bool _agreementCheckBox = false;
  bool _isValidEmail = true;

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

  void _validateEmail() {
    if (!StringUtils.isValidEmail(_individualEmailController.text)) {
      setState(() {
        _isValidEmail = false;
      });
    } else {
      setState(() {
        _isValidEmail = true;
      });
    }
  }

  void _onRegisterPressed() async {
    BlocProvider.of<IndividualBasicInformationBloc>(context).add(
      RegisterPressed(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        middleName: _middleNameController.text,
        suffix: _suffixController.text,
        birthDate: _birthDateController.text != "" ? StringUtils.convertDateFromString(_birthDateController.text) : null,
        gender: _genderValue != null ? _genderValue : null,
        pin: _pinController.text,
        contactNumber: _contactNumberController.text,
        email: _individualEmailController.text.trim(),
        userAddress: UserAddress(
          streetHouseNo: _streetHouseNumController.text,
          brgyCode: _selectedBarangay.brgyCode,
          brgyName: _selectedBarangay.brgyDesc,
          citymunCode: _selectedCity.citymunCode,
          citymunName: _selectedCity.citymunDesc,
          provCode: _selectedProvince.provCode,
          provName: _selectedProvince.provDesc,
        ),
      ),
    );
  }

  bool _checkValidityBasicInfo1() {
    int changeCount = 0;

    changeCount += _firstNameController.text.isNotEmpty ? 1 : 0;
    changeCount += _lastNameController.text.isNotEmpty ? 1 : 0;
    // changeCount += _birthDateController.text.isNotEmpty ? 1 : 0;
    // changeCount += _genderController.text.isNotEmpty ? 1 : 0;

    return changeCount == 2 ? true : false;
  }

  void _validatePIN() {
    final pinMatched = _pinController.text == _confirmPinController.text;
    if (_pinMatched != pinMatched) {
      setState(() {
        _pinMatched = pinMatched;
      });
    }
  }

  bool _checkValidityBasicInfo2() {
    bool fieldsNotEmpty = false;
    bool isPinConfirmed = false;

    int changeCount = 0;
    changeCount += _pinController.text.isNotEmpty ? 1 : 0;
    changeCount += _confirmPinController.text.isNotEmpty ? 1 : 0;
    changeCount += _streetHouseNumController.text.isNotEmpty ? 1 : 0;

    if (changeCount == 3) {
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

  void _onChangeValidityBasicInfo1() {
    final bool isValid = _checkValidityBasicInfo1();
    if (_basicInfo1IsValid != isValid) {
      setState(() {
        _basicInfo1IsValid = isValid;
      });
    }
  }

  void _onChangeValidityBasicInfo2() {
    final bool isValid = _checkValidityBasicInfo2();
    if (_basicInfo2IsValid != isValid) {
      setState(() {
        _basicInfo2IsValid = isValid;
      });
    }
  }

  void _validateContactNumber() {
    BlocProvider.of<IndividualBasicInformationBloc>(context).add(
      ValidateContactNumber(
        contactNumber: _contactNumberController.text,
      ),
    );
  }

  void selectProvinceCallback(Province selectedProvince) {
    _selectedProvince = selectedProvince;
    _onChangeValidityBasicInfo2();
  }

  void selectCityCallback(City selectedCity) {
    _selectedCity = selectedCity;
    _onChangeValidityBasicInfo2();
  }

  void selectBarangayCallback(Barangay selectedBarangay) {
    _selectedBarangay = selectedBarangay;
    _onChangeValidityBasicInfo2();
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
          ],
          onPageChanged: (int index) {},
        ),
      ),
    );
  }

  Widget _basicInformationPage2() {
    return CustomRegularAppBar(
      backgroundColor: Colors.transparent,
      onBackTap: () {
        _onChangeValidityBasicInfo1();
        _goToPage(_pageControllerIndex - 1);
      },
      body: BlocConsumer<IndividualBasicInformationBloc,
          IndividualBasicInformationState>(
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
                    _buildCreatePINTextField(),
                    _buildConfirmPINTextField(),
                    _buildIndividualEmailTextField(),
                    _buildContactNumberTextField(),
                    AddressWidget(
                      selectProvinceCallback: (selectedProvince) =>
                          selectProvinceCallback(selectedProvince),
                      selectCityCallback: (selectedCity) =>
                          selectCityCallback(selectedCity),
                      selectBarangayCallback: (selectedBarangay) =>
                          selectBarangayCallback(selectedBarangay),
                      previouslySelectedProvince: _selectedProvince,
                      previouslySelectedCity: _selectedCity,
                      previouslySelectedBarangay: _selectedBarangay,
                    ),
                    _buildStreetHouseNumTextField(),
                    _buildAgreementLabel(),
                  ],
                ),
                SizedBox(height: 30),
                _buildContinuePage2Button(state)
              ],
            ),
          );
        },
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
                _buildSuffixTextField(),
                _buildBirthdateTextField(),
                _buildGenderNameTextField()
              ],
            ),
            SizedBox(height: 30),
            _buildWarningNote(),
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
          controller: _pinController,
          maxLength: 4,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
          obscureText: true,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration: TextFieldTheme.textfieldInputDecoration(
              hintText: "Create 4 digit PIN"),
          onChanged: (value) {
            _validatePIN();
            _onChangeValidityBasicInfo2();
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
          controller: _confirmPinController,
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
          onChanged: (value) {
            _validatePIN();
            _onChangeValidityBasicInfo2();
          },
        ),
      ),
    );
  }

  Widget _buildIndividualEmailTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextFormField(
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration: TextFieldTheme.textfieldInputDecoration(
            hintText: "Email",
            errorText: _isValidEmail ? null : "Invalid email",
          ),
          controller: _individualEmailController,
          onChanged: (value) {
            _validateEmail();
            _onChangeValidityBasicInfo2();
          },
        ),
      ),
    );
  }

  Widget _buildContactNumberTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: BlocConsumer<IndividualBasicInformationBloc,
            IndividualBasicInformationState>(
          listenWhen: (previousState, currentState) =>
              currentState is ContactNumberState,
          listener: (context, state) {
            if (state is ContactNumberValidationFailure) {
              ToastUtil.showToast(context, state.error.toString());
            }

            _contactNumberIsValid =
                state is ContactNumberIsValid ? true : false;
            _onChangeValidityBasicInfo2();
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
              controller: _contactNumberController,
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
          controller: _streetHouseNumController,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration: TextFieldTheme.textfieldInputDecoration(
              hintText: "Street/House No."),
          onChanged: (value) => _onChangeValidityBasicInfo2(),
        ),
      ),
    );
  }

  Widget _buildGenderNameTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextField(
          onTap: () {
            _showGenderPickerDialog();
          },
          controller: _genderController,
          readOnly: true,
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
          controller: _firstNameController,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration:
              TextFieldTheme.textfieldInputDecoration(hintText: "First Name"),
          onChanged: (text) => _onChangeValidityBasicInfo1(),
        ),
      ),
    );
  }

  Widget _buildMiddleNameTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextFormField(
          controller: _middleNameController,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration:
              TextFieldTheme.textfieldInputDecoration(hintText: "Middle Name"),
        ),
      ),
    );
  }

  Widget _buildSuffixTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextField(
          onTap: () {
            _showSuffixPickerDialog();
          },
          controller: _suffixController,
          readOnly: true,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration:
              TextFieldTheme.textfieldInputDecoration(hintText: "Suffix"),
        ),
      ),
    );
  }

  Widget _buildLastNameTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextFormField(
          controller: _lastNameController,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration:
              TextFieldTheme.textfieldInputDecoration(hintText: "Last Name"),
          onChanged: (text) => _onChangeValidityBasicInfo1(),
        ),
      ),
    );
  }

  Widget _buildBirthdateTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextFormField(
          readOnly: true,
          onTap: () {
            selectDate(context);
          },
          controller: _birthDateController,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration:
              TextFieldTheme.textfieldInputDecoration(hintText: "Birth Date"),
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
                  _agreementCheckBox = value ?? false;
                });
              });
              _onChangeValidityBasicInfo2();
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
                    _onChangeValidityBasicInfo2();
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

  // Future<void> _showTnCAlertDialog() async {
  //   await showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return TermsAndConditionCustomDialog();
  //       }).then(
  //     (value) {
  //       if (value != null) {
  //         setState(
  //           () {
  //             _agreementCheckBox = value;
  //             _onChangeValidityBasicInfo2();
  //           },
  //         );
  //       }
  //     },
  //   );
  // }

  Widget _buildWarningNote() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.red[50],
        border: Border(
          left: BorderSide(
            width: 8,
            color: Colors.red,
          ),
        ),
      ),
      child: Text(
        "Please make sure all details are correct to avoid delay or problem with your account in the future.",
        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildContinuePage1Button() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: PrimaryButton(
        text: "CONTINUE",
        fontSize: 14,
        onPressed: _basicInfo1IsValid
            ? () {
                _goToPage(_pageControllerIndex + 1);
                _validateContactNumber();
                _onChangeValidityBasicInfo2();
              }
            : null,
        color: _basicInfo1IsValid ? ColorUtil.primaryColor : Colors.grey,
      ),
    );
  }

  Widget _buildContinuePage2Button(state) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: PrimaryButton(
        text: "Continue",
        isLoading: state is RegisterProgress ? true : false,
        fontSize: 14,
        onPressed: _basicInfo2IsValid ? () => _onRegisterPressed() : null,
        color: _basicInfo2IsValid ? ColorUtil.primaryColor : Colors.grey,
      ),
    );
  }

  Future<void> _showGenderPickerDialog() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return GenderCustomDialog(genderValue: gender);
        }).then(
      (value) {
        setState(
          () {
            gender = value ?? gender;
            _genderController.text = gender;
            switch (gender?.toLowerCase()) {
              case 'male':
                _genderValue = Gender.male;
                break;
              case 'female':
                _genderValue = Gender.female;
                break;
              default:
            }
          },
        );
        _onChangeValidityBasicInfo1();
      },
    );
  }

  Future<void> _showSuffixPickerDialog() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SuffixPickerDialog(selectedValue: _suffixController.text);
        }).then(
      (value) {
        setState(
          () {
            _suffixController.text = value ?? _suffixController.text;
          },
        );
        _onChangeValidityBasicInfo1();
      },
    );
  }

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _datepicked == null ? _date : _datepicked,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    if (picked != null && picked != _datepicked) {
      setState(() {
        _datepicked = picked;
        _birthDateController = TextEditingController(
            text:
                "${_datepicked.month}/${_datepicked.day}/${_datepicked.year}");
      });
    }
    _onChangeValidityBasicInfo1();
  }
}
