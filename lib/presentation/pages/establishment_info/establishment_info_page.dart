import 'package:flutter/material.dart';

import '../../../core/utils/color_util.dart';
import '../../../core/utils/style/textfield_theme.dart';
import '../../widgets/buttons/primary_button_widget.dart';
import '../../widgets/texts/description_text.dart';
import '../../widgets/texts/header_text.dart';

class EstablishmentInfoPage extends StatefulWidget {
  EstablishmentInfoPage({Key key}) : super(key: key);

  @override
  _EstablishmentInfoPageState createState() => _EstablishmentInfoPageState();
}

class _EstablishmentInfoPageState extends State<EstablishmentInfoPage> {
  final double textFieldMargin = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  child: HeaderText(
                    title: "Establishment Info",
                    fontSize: 24,
                  ),
                ),
                _buildEstablishmentNameTextField(),
                _buildCreatePINTextField(),
                _buildConfirmPINTextField(),
                _buildContactNumberTextField(),
                _buildAddressTextArea(),
                _buildConditions(),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildEstablishmentNameTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: TextFormField(
        style: TextStyle(fontSize: 14.0),
        decoration:
            TextFieldTheme.textfieldInputDecoration(hintText: "First Name"),
      ),
    );
  }

  _buildCreatePINTextField() {
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

  _buildConfirmPINTextField() {
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

  _buildContactNumberTextField() {
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

  _buildAddressTextArea() {
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

  _buildConditions() {
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

  _buildSubmitButton() {
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
