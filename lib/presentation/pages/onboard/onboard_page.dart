import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:radar_qrcode_flutter/core/utils/toasts/toast_util.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../core/utils/color_util.dart';
import '../../widgets/buttons/standard_button_widget.dart';
import '../../widgets/texts/light_text.dart';
import 'package:url_launcher/url_launcher.dart';

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
            padding: EdgeInsets.only(top: sy(24), bottom: sy(10), left: sy(24), right: sy(24) ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: sy(16)),
                  child: ExtendedImage.asset(
                    'assets/images/app/logo-white.png',
                    width: sx(130),
                  ),
                ),
                Spacer(flex: 30),
                ExtendedImage.asset(
                  'assets/images/app/onboard_graphic.png',
                  width: sx(400),
                ),
                Spacer(flex: 10),
                Text(
                  'Be Part of the Change',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: sy(15.5),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
                LightText(
                    text:
                        'By using Radar, you are helping to stop the spread of any potential viruses, and protecting your community.'),
                Spacer(flex: 25),
                StandardButton(
                  text: 'REGISTER NOW',
                  onPressed: () {
                    Navigator.of(context).pushNamed(REGISTER_AS_ROUTE);
                  },
                ),
                Spacer(flex: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LightText(
                      text: 'Already have an account?',
                      horizontalPadding: sy(4),
                    ),
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
                Spacer(flex: 30),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await _launchURL(context);
                          },
                          child: Text(
                            'Privacy Policy and Terms & Conditions',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: sy(10),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
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

  _launchURL(BuildContext context) async {
    const url = 'https://radarph.online/tc.pdf';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
        ToastUtil.showToast(
            context, "URL error.");
    }
  }
}
