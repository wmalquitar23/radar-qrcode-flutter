import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../core/utils/color_util.dart';
import '../../widgets/buttons/standard_button_widget.dart';
import '../../widgets/texts/light_text.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Scaffold(
          body: Container(
            height: height,
            width: width,
            color: ColorUtil.onboardBackground,
            padding: EdgeInsets.all(sy(24)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: sy(16)),
                  child: ExtendedImage.asset(
                    'assets/images/app/logo-white.png',
                    width: sx(150),
                  ),
                ),
                Spacer(flex: 30),
                ExtendedImage.asset('assets/images/app/onboard_graphic.png'),
                Spacer(flex: 30),
                Text(
                  'Be Part of the Change',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: sy(15.5),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
                LightText(
                    text:
                        'By using Radar, you are helping to stop the spread of COVID-19, and protecting your community.'),
                Spacer(flex: 30),
                StandardButton(
                  text: 'REGISTER NOW',
                  onPressed: () {
                    Navigator.of(context).pushNamed(REGISTER_AS_ROUTE);
                  },
                ),
                Spacer(flex: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LightText(
                        text: 'Already have an account?',
                        horizontalPadding: sy(4)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SIGN_IN_ROUTE);
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: sy(10),
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
