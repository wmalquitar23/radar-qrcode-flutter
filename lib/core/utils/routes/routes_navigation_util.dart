import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/router_util.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/address_picker/address_picker_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/establishment/establishment_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/establishment_signup/establishment_basic_information_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/individual_signup/individual_basic_information_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/register_as/register_as_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/user_details/user_details_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/verification/verification_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/success/success_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/individual/individual_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/profile/profile_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/change_pin/change_pin_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/pages/basic_information/address/address_picker_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/basic_information/establishment_basic_information.dart';
import 'package:radar_qrcode_flutter/presentation/pages/basic_information/individual_basic_information_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/change_pin/change_pin_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/contact_us/contact_us_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/errors/not_found_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/establishment_home/establishment_home_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/identity_verification/dummy_camera_view.dart';
import 'package:radar_qrcode_flutter/presentation/pages/identity_verification/identity_verification_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/identity_verification/upload_id_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/identity_verification/upload_result_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/individual_home/individual_home.dart';
import 'package:radar_qrcode_flutter/presentation/pages/onboard/onboard_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/profile/my_profile_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/register_as/register_as_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/scan_qrcode/scan_qrcode.dart';
import 'package:radar_qrcode_flutter/presentation/pages/signin/sign_in_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/signin/sign_in_verification.dart';
import 'package:radar_qrcode_flutter/presentation/pages/success/success_page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/user_details/user_details.page.dart';
import 'package:radar_qrcode_flutter/presentation/pages/verification/verification_page.dart';

import '../../../dependency_instantiator.dart';
import 'router_util.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final args = settings.arguments;
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
          page: BlocProvider(
            create: (_) => sl<IndividualBasicInformationBloc>(),
            child: IndividualBasicInformationPage(),
          ),
          settings: settings,
          pageTransitionType: PageTransitionType.rightToLeftWithFade);
      break;
    case INDIVIDUAL_HOME_ROUTE:
      return pushNamed(
          page: BlocProvider(
            create: (_) => sl<IndividualBloc>(),
            child: IndividualHomePage(),
          ),
          settings: settings,
          pageTransitionType: PageTransitionType.rightToLeftWithFade);
      break;
    case ESTABLISHMENT_INFO_ROUTE:
      return pushNamed(
          page: BlocProvider(
              create: (_) => sl<EstablishmentBasicInformationBloc>(),
              child: EstablishmentBasicInformationPage()),
          settings: settings,
          pageTransitionType: PageTransitionType.rightToLeftWithFade);
      break;
    case ESTABLISHMENT_HOME_ROUTE:
      return pushNamed(
          page: BlocProvider(
            create: (_) => sl<EstablishmentBloc>(),
            child: EstablishmentHomePage(),
          ),
          settings: settings,
          pageTransitionType: PageTransitionType.rightToLeftWithFade);
      break;
    case SUCCESS_ROUTE:
      return pushNamed(
          page: BlocProvider(
            create: (_) => sl<SuccessBloc>(),
            child: SuccessPage(),
          ),
          settings: settings,
          pageTransitionType: PageTransitionType.rightToLeftWithFade);
      break;
    case USER_DETAILS_ROUTE:
      return pushNamed(
          page: BlocProvider(
            create: (_) => sl<UserDetailsBloc>(),
            child: UserDetailsPage(
              qrInformation: args,
            ),
          ),
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
          page: BlocProvider(
            create: (_) => sl<ProfileBloc>(),
            child: MyProfilePage(),
          ),
          settings: settings,
          pageTransitionType: PageTransitionType.fade);
      break;
    case VERIFICATION_CODE_ROUTE:
      return pushNamed(
          page: BlocProvider(
            create: (_) => sl<VerificationBloc>(),
            child: VerificationPage(
              contactNumber: args,
            ),
          ),
          settings: settings,
          pageTransitionType: PageTransitionType.fade);
      break;
    case CHANGE_PIN_ROUTE:
      return pushNamed(
          page: BlocProvider(
            create: (_) => sl<ChangePinBloc>(),
            child: ChangePINPage(),
          ),
          settings: settings,
          pageTransitionType: PageTransitionType.fade);
      break;
    case CONTACT_US_ROUTE:
      return pushNamed(
          page: ContactUsPage(),
          settings: settings,
          pageTransitionType: PageTransitionType.fade);
      break;
    case SIGN_IN_ROUTE:
      return pushNamed(
          page: SignInPage(),
          settings: settings,
          pageTransitionType: PageTransitionType.fade);
      break;
    case SIGN_IN_VERIFICATION_ROUTE:
      return pushNamed(
          page: SignInVerificationPage(contactNumber: settings.arguments),
          settings: settings,
          pageTransitionType: PageTransitionType.fade);
      break;
    case IDENTITY_VERIFICATION_ROUTE:
      return pushNamed(
          page: IdentityVerificationPage(),
          settings: settings,
          pageTransitionType: PageTransitionType.fade);
      break;
    case UPLOAD_ID_ROUTE:
      return pushNamed(
          page: UploadIDPage(),
          settings: settings,
          pageTransitionType: PageTransitionType.fade);
      break;
    case UPLOAD_ID_RESULT_ROUTE:
      return pushNamed(
        page: UploadResultPage(),
        settings: settings,
        pageTransitionType: PageTransitionType.fade,
      );
    case DUMMY_CAMERA_VIEW_ROUTE:
      return pushNamed(
        page: DummyCameraViewPage(),
        settings: settings,
        pageTransitionType: PageTransitionType.fade,
      );
      break;
    case ADDRESS_PICKER_PAGE_ROUTE:
      return pushNamed(
        page: BlocProvider(
          create: (_) => sl<AddressPickerBloc>(),
          child: AddressPickerPage(
            args: args,
          ),
        ),
        settings: settings,
        pageTransitionType: PageTransitionType.fade,
      );
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
