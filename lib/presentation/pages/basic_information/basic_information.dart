import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/style/textfield_theme.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/pages/mobile_status_margin_top.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/description_text.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/header_text.dart';

class BasicInformation extends StatefulWidget {
  @override
  _BasicInformationState createState() => _BasicInformationState();
}

class _BasicInformationState extends State<BasicInformation> {
  final double textFieldMargin = 10.0;
  @override
  Widget build(BuildContext context) {
    return MobileStatusMarginTop(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  child: HeaderText(
                    title: "Basic Information",
                    fontSize: 24,
                  ),
                ),
                _buildFirstNameTextField(),
                _buildMiddleNameTextField(),
                _buildLastNameTextField(),
                _buildCreatePINTextField(),
                _buildConfirmPINTextField(),
                _buildContactNumberTextField(),
                _buildAddressTextArea(),
                _buildConditions(),
                SizedBox(
                  height: 20.0,
                ),
                _buildSubmitButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConditions() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: SizedBox(
                width: Checkbox.width,
                height: Checkbox.width,
                child: Container(
                  decoration: new BoxDecoration(
                    border: Border.all(
                      width: 1,
                    ),
                    borderRadius: new BorderRadius.circular(5),
                  ),
                  child: Theme(
                    data: ThemeData(
                      unselectedWidgetColor: Colors.transparent,
                    ),
                    child: Checkbox(
                      value: false,
                      onChanged: (state) {},
                      activeColor: Colors.transparent,
                      checkColor: ColorUtil.primaryColor,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Row(
            children: <Widget>[
              DescriptionText(title: "I have read and agree to the "),
              DescriptionText(
                title: "terms and conditions",
                color: ColorUtil.primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFirstNameTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: TextFormField(
        style: TextStyle(fontSize: 14.0),
        decoration:
            TextFieldTheme.textfieldInputDecoration(hintText: "First Name"),
      ),
    );
  }

  Widget _buildMiddleNameTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: TextFormField(
        style: TextStyle(fontSize: 14.0),
        decoration:
            TextFieldTheme.textfieldInputDecoration(hintText: "Middle Name"),
      ),
    );
  }

  Widget _buildLastNameTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: TextFormField(
        style: TextStyle(fontSize: 14.0),
        decoration:
            TextFieldTheme.textfieldInputDecoration(hintText: "Last Name"),
      ),
    );
  }

  Widget _buildCreatePINTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: TextFormField(
        obscureText: true,
        style: TextStyle(fontSize: 14.0),
        decoration:
            TextFieldTheme.textfieldInputDecoration(hintText: "Create PIN"),
      ),
    );
  }

  Widget _buildConfirmPINTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: TextFormField(
        obscureText: true,
        style: TextStyle(fontSize: 14.0),
        decoration:
            TextFieldTheme.textfieldInputDecoration(hintText: "Confirm PIN"),
      ),
    );
  }

  Widget _buildContactNumberTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: TextFormField(
        obscureText: true,
        style: TextStyle(fontSize: 14.0),
        decoration:
            TextFieldTheme.textfieldInputDecoration(hintText: "Contact Number"),
      ),
    );
  }

  Widget _buildAddressTextArea() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: TextFormField(
        readOnly: true,
        maxLines: 5,
        style: TextStyle(fontSize: 14.0),
        decoration: TextFieldTheme.textAreaInputDecoration(hintText: "Address"),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: PrimaryButton(
        text: "Submit",
        fontSize: 14,
        onPressed: () {},
      ),
    );
  }
}
