import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar_qrcode_flutter/core/utils/style/textfield_theme.dart';
import 'package:radar_qrcode_flutter/core/utils/toasts/toast_util.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/change_pin/change_pin_bloc.dart';
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

  TextEditingController _oldPINController = TextEditingController();
  TextEditingController _newPINController = TextEditingController();
  TextEditingController _confirmPINController = TextEditingController();

  void _savePIN() async {
    BlocProvider.of<ChangePinBloc>(context).add(
      OnSaveNewPIN(
        oldPIN: _oldPINController.text,
        newPIN: _newPINController.text,
        confirmPIN: _confirmPINController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MobileStatusMarginTop(
      child: CustomRegularAppBar(
        backgroundColor: Colors.transparent,
        title: "Change PIN",
        body: BlocConsumer<ChangePinBloc, ChangePinState>(
          listener: (context, state) {
            if (state is ChangePINFailure) {
              ToastUtil.showToast(context, state.error);
            }
            if (state is ChangePINSuccess) {
              ToastUtil.showToast(context, "Your PIN was successfully updated");
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Container(
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
                  SizedBox(
                    height: 70,
                  ),
                  PrimaryButton(
                    text: "SAVE NEW PIN",
                    onPressed: () {
                      _savePIN();
                    },
                    isLoading: state is ChangePINLoading ? true : false,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOldPINTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: textFieldMargin),
      child: ShadowWidget(
        child: TextField(
          maxLength: 4,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
          controller: _oldPINController,
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
          maxLength: 4,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
          controller: _newPINController,
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
          maxLength: 4,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
          controller: _confirmPINController,
          obscureText: true,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration: TextFieldTheme.textfieldInputDecoration(
              hintText: "Re-type new PIN to confirm"),
        ),
      ),
    );
  }
}
