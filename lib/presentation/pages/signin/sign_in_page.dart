import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/navigation/navigation_service.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:radar_qrcode_flutter/core/utils/style/textfield_theme.dart';
import 'package:radar_qrcode_flutter/dependency_instantiator.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/bar/custom_regular_app_bar.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/buttons/primary_button_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/pages/mobile_status_margin_top.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/properties/shadow_widget.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/description_text.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/texts/header_text.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final NavigatorService _navigatorService = sl.get<NavigatorService>();
  final TextEditingController _contactNumberController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MobileStatusMarginTop(
      child: CustomRegularAppBar(
        onBackTap: () {
          Navigator.pushNamed(context, ONBOARD_ROUTE);
        },
        backgroundColor: Colors.transparent,
        title: "Sign in",
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 40.0),
                child: HeaderText(
                  title: "Enter your mobile number to Sign in",
                  fontWeight: FontWeight.w800,
                  textAlign: TextAlign.center,
                  color: ColorUtil.primaryColor,
                ),
              ),
              _buildContactNumberTextField(),
              SizedBox(
                height: 40.0,
              ),
              PrimaryButton(
                  text: "SIGN IN",
                  onPressed: () => _navigatorService.pushNamed(
                      SIGN_IN_VERIFICATION_ROUTE,
                      arguments: _contactNumberController.text)),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DescriptionText(
                    title: "Don\'t have an account? ",
                    fontWeight: FontWeight.w500,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, REGISTER_AS_ROUTE);
                    },
                    child: DescriptionText(
                      title: "Register",
                      fontWeight: FontWeight.w600,
                      color: ColorUtil.primaryColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _contactNumberController.dispose();
    super.dispose();
  }

  Widget _buildContactNumberTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
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
            hintText: "9XX-XXX-XXXX",
            prefix: "+63",
          ),
          autovalidate: true,
        ),
      ),
    );
  }
}
