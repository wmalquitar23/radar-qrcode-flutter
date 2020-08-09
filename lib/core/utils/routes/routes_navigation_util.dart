import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/router_util.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:radar_qrcode_flutter/presentation/pages/basic_information/basic_information.dart';
import 'package:radar_qrcode_flutter/presentation/pages/errors/not_found_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/getstarted/get_started_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/home/home_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/onboarding/onboarding_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/verification_code/verification_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // final args = settings.arguments;
  switch (settings.name) {
    case ONBOARD_ROUTE:
      return pushNamed(page: OnBoardingPage(), settings: settings);
      break;
    case GETSTARTED_ROUTE:
      return pushNamed(
          page: GetStartedPage(),
          settings: settings,
          pageTransitionType: PageTransitionType.rightToLeftWithFade);
      break;
    case BASIC_INFORMATION_ROUTE:
      return pushNamed(
          page: BasicInformation(),
          settings: settings,
          pageTransitionType: PageTransitionType.rightToLeftWithFade);
      break;
    case VERIFICATION_CODE_ROUTE:
      return pushNamed(
          page: VerificationPage(),
          settings: settings,
          pageTransitionType: PageTransitionType.rightToLeftWithFade);
      break;
    case HOME_PAGE_ROUTE:
      return pushNamed(
          page: HomePage(),
          settings: settings,
          pageTransitionType: PageTransitionType.rightToLeftWithFade);
      break;
    default:
      return _errorRoute(settings);
      break;
  }
}

Route<dynamic> _errorRoute(RouteSettings settings) {
  return MaterialPageRoute(
      builder: (context) => NotFoundPage(
            name: settings.name,
          ));
}
