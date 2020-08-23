import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/style/textfield_theme.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/bar/custom_regular_app_bar.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/pages/mobile_status_margin_top.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/properties/shadow_widget.dart';

class ChangePINPage extends StatefulWidget {
  @override
  _ChangePINPageState createState() => _ChangePINPageState();
}

class _ChangePINPageState extends State<ChangePINPage> {
  final double textFieldMargin = 10.0;

  @override
  Widget build(BuildContext context) {
    return MobileStatusMarginTop(
      child: CustomRegularAppBar(
        backgroundColor: Colors.transparent,
        title: "Change PIN",
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  _buildOldPINTextField(),
                  _buildNewPINTextField(),
                  _buildRetypePINTextField()
                ],
              ),
              SizedBox(height: 70,),
              PrimaryButton(
                text: "SAVE NEW PIN",
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOldPINTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextField(
          obscureText: true,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration:
              TextFieldTheme.textfieldInputDecoration(hintText: "Old PIN"),
        ),
      ),
    );
  }

  Widget _buildNewPINTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextField(
          obscureText: true,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration:
              TextFieldTheme.textfieldInputDecoration(hintText: "New PIN"),
        ),
      ),
    );
  }

  Widget _buildRetypePINTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextField(
          obscureText: true,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration: TextFieldTheme.textfieldInputDecoration(
              hintText: "Re-type new PIN to confirm"),
        ),
      ),
    );
  }
}
