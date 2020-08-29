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
import 'package:radar_qrcode_flutter/presentation/bloc/individual_signup/individual_basic_information_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/bar/custom_regular_app_bar.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/dialogs/gender_dialog.dart';
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
  TextEditingController _birthDateController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _pinController = TextEditingController();
  TextEditingController _confirmPinController = TextEditingController();
  TextEditingController _contactNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  int _pageControllerIndex;
  String gender;
  Gender _genderValue;

  DateTime _datepicked;

  DateTime _date = DateTime.now();

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

  void _onRegisterPressed() async {
    BlocProvider.of<IndividualBasicInformationBloc>(context).add(
      RegisterPressed(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        middleName: _middleNameController.text,
        birthDate: StringUtils.convertDateFromString(_birthDateController.text),
        gender: _genderValue,
        pin: _pinController.text,
        contactNumber: _contactNumberController.text,
        address: _addressController.text,
      ),
    );
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
        _goToPage(_pageControllerIndex - 1);
      },
      body: BlocConsumer<IndividualBasicInformationBloc,
          IndividualBasicInformationState>(
        listener: (context, state) {
          if (state is RegisterDone) {
            Navigator.pushNamed(context, VERIFICATION_CODE_ROUTE);
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
                    _buildContactNumberTextField(),
                    _buildAddressTextField()
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
          controller: _pinController,
          maxLength: 4,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
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
          ),
        ),
      ),
    );
  }

  Widget _buildContactNumberTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextFormField(
          controller: _contactNumberController,
          maxLength: 10,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration: TextFieldTheme.textfieldInputDecoration(
            hintText: "Contact Number",
            prefix: "+63",
          ),
        ),
      ),
    );
  }

  Widget _buildAddressTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextFormField(
          controller: _addressController,
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
          onTap: () {
            _showAlertDialog();
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

  Widget _buildLastNameTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextFormField(
          controller: _lastNameController,
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

  Widget _buildContinuePage2Button(state) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: PrimaryButton(
        text: "CONTINUE",
        isLoading: state is RegisterProgress ? true : false,
        fontSize: 14,
        onPressed: () {
          _onRegisterPressed();
        },
      ),
    );
  }

  Future<void> _showAlertDialog() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return GenderCustomDialog(genderValue: gender);
        }).then(
      (value) {
        setState(
          () {
            gender = value;
            _genderController.text = value;
            switch (value.toLowerCase()) {
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
  }
}
