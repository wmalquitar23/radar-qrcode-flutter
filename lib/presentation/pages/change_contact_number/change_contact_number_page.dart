import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:radar_qrcode_flutter/core/utils/style/textfield_theme.dart';
import 'package:radar_qrcode_flutter/core/utils/toasts/toast_util.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/change_contact_number/change_contact_number_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/bar/custom_regular_app_bar.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/pages/mobile_status_margin_top.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/properties/shadow_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/header_text.dart';

class ChangeContactNumberPage extends StatefulWidget {
  final User user;
  const ChangeContactNumberPage({Key key, this.user}) : super(key: key);

  @override
  _ChangeContactNumberPageState createState() =>
      _ChangeContactNumberPageState();
}

class _ChangeContactNumberPageState extends State<ChangeContactNumberPage> {
  final double textFieldMargin = 10.0;

  TextEditingController _contactNumberController = TextEditingController();

  bool _contactNumberIsValid = false;
  bool _basicInfo2IsValid = false;

  void _onRegisterPressed() async {
    BlocProvider.of<ChangeContactNumberBloc>(context).add(ContinueButtonPressed(
        firstName: widget.user.firstName,
        middleName: widget.user.middleName,
        lastName: widget.user.lastName,
        pin: widget.user.pin,
        birthDate: widget.user.birthDate,
        gender: widget.user.gender,
        address: widget.user.address,
        contactNumber: _contactNumberController.text));
  }

  void _onChangeValidityBasicInfo2() {
    final bool isValid = _checkValidityBasicInfo2();
    if (_basicInfo2IsValid != isValid) {
      setState(() {
        _basicInfo2IsValid = isValid;
      });
    }
  }

  bool _checkValidityBasicInfo2() {
    return (_contactNumberIsValid);
  }

  void _validateContactNumber() {
    BlocProvider.of<ChangeContactNumberBloc>(context).add(
      ValidateContactNumber(
        contactNumber: _contactNumberController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MobileStatusMarginTop(
      child: Scaffold(
        body: _basicInformationPage2(),
      ),
    );
  }

  Widget _buildContinueButton(state) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: PrimaryButton(
        text: "CONTINUE",
        //isLoading: state is RegisterProgress ? true : false,
        fontSize: 14,
        onPressed: _basicInfo2IsValid ? () => _onRegisterPressed() : null,
        color: _basicInfo2IsValid ? ColorUtil.primaryColor : Colors.grey,
      ),
    );
  }

  Widget _basicInformationPage2() {
    return CustomRegularAppBar(
      backgroundColor: Colors.transparent,
      onBackTap: () {},
      body: BlocConsumer<ChangeContactNumberBloc, ChangeContactNumberState>(
        listener: (context, state) {
          if (state is RegisterDone) {
            Navigator.pushNamed(
              context,
              VERIFICATION_CODE_ROUTE,
              arguments: User(
                  firstName: widget.user.firstName,
                  middleName: widget.user.middleName,
                  lastName: widget.user.lastName,
                  pin: widget.user.pin,
                  birthDate: widget.user.birthDate,
                  gender: widget.user.gender,
                  address: widget.user.address,
                  contactNumber: _contactNumberController.text),
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
                        title: "Enter New Phone Number",
                        fontSize: 22,
                        color: ColorUtil.primaryColor,
                      ),
                    ),
                    _buildContactNumberTextField(),
                    SizedBox(
                      height: 50,
                    ),
                    _buildContinueButton(state)
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContactNumberTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: BlocConsumer<ChangeContactNumberBloc, ChangeContactNumberState>(
          listenWhen: (previousState, currentState) =>
              currentState is ChangeContactNumberState,
          listener: (context, state) {
            if (state is ContactNumberValidationFailure) {
              ToastUtil.showToast(context, state.error);
            }

            _contactNumberIsValid =
                state is ContactNumberIsValid ? true : false;
            _onChangeValidityBasicInfo2();
          },
          buildWhen: (previousState, currentState) =>
              currentState is ChangeContactNumberState &&
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
}
