import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/splash/splash_bloc.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../core/utils/color_util.dart';
import '../../../core/utils/routes/routes_list.dart';
import '../../../dependency_instantiator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void didChangeDependencies() {
    sl<SplashBloc>().load(onboard);
    super.didChangeDependencies();
  }

  void onboard() async {
    Navigator.pushNamed(context, ONBOARD_PAGE_ROUTE);
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Scaffold(
          body: Container(
            height: height,
            width: width,
            color: Colors.white,
            padding: EdgeInsets.all(sy(18)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                ExtendedImage.asset(
                  'assets/images/app/logo-black.png',
                  width: sx(300),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'by',
                      style: TextStyle(
                        color: ColorUtil.primaryTextColor,
                        fontSize: sy(11),
                      ),
                    ),
                    SizedBox(width: sx(12)),
                    Text(
                      'travelpud',
                      style: TextStyle(
                        color: ColorUtil.primaryColor2,
                        fontSize: sy(14),
                        fontWeight: FontWeight.w700,
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
