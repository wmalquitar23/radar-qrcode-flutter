import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/router_util.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/register_as/register_as_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/pages/basic_information/individual_basic_information_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/change_pin/change_pin_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/errors/not_found_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/establishment_info/establishment_info_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/establishment_home/establishment_home_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/individual_home/individual_home.dart';
import 'package:radar_qrcode_flutter/presentation/pages/onboard/onboard_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/profile/my_profile_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/register_as/register_as_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/scan_qrcode/scan_qrcode.dart';
import 'package:radar_qrcode_flutter/presentation/pages/success/success_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/user_details/user_details.page.dart';

import '../../../dependency_instantiator.dart';
import 'routes_list.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // final args = settings.arguments;
  switch (settings.name) {
    case ONBOARD_ROUTE:
      return pushNamed(page: OnboardPage(), settings: settings);
      break;
    case REGISTER_AS_ROUTE:
      return pushNamed(
          page: BlocProvider(
            create: (_) => sl<RegisterAsBloc>(),
            child: RegisterAsPage(),
          ),
          settings: settings,
          pageTransitionType: PageTransitionType.rightToLeftWithFade);
      break;
    case BASIC_INFORMATION_ROUTE:
      return pushNamed(
          page: IndividualBasicInformationPage(),
          settings: settings,
          pageTransitionType: PageTransitionType.rightToLeftWithFade);
      break;
    case INDIVIDUAL_HOME_ROUTE:
      return pushNamed(
          page: IndividualHomePage(),
          settings: settings,
          pageTransitionType: PageTransitionType.fade);
      break;
    case ESTABLISHMENT_INFO_ROUTE:
      return pushNamed(
          page: EstablishmentInfoPage(),
          settings: settings,
          pageTransitionType: PageTransitionType.rightToLeftWithFade);
      break;
    case ESTABLISHMENT_HOME_ROUTE:
      return pushNamed(
          page: EstablishmentHomePage(),
          settings: settings,
          pageTransitionType: PageTransitionType.rightToLeftWithFade);
      break;
    case SUCCESS_ROUTE:
      return pushNamed(
          page: SuccessPage(),
          settings: settings,
          pageTransitionType: PageTransitionType.rightToLeftWithFade);
      break;
    case USER_DETAILS_ROUTE:
      return pushNamed(
          page: UserDetailsPage(),
          settings: settings,
          pageTransitionType: PageTransitionType.rightToLeftWithFade);
      break;
    case SCAN_QRCODE_ROUTE:
      return pushNamed(
          page: ScanQrcodePage(),
          settings: settings,
          pageTransitionType: PageTransitionType.rightToLeftWithFade);
      break;
    case MY_PROFILE_ROUTE:
      return pushNamed(
          page: MyProfilePage(),
          settings: settings,
          pageTransitionType: PageTransitionType.fade);
      break;
    case CHANGE_PIN_ROUTE:
      return pushNamed(
          page: ChangePINPage(),
          settings: settings,
          pageTransitionType: PageTransitionType.fade);
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
    ),
  );
}
