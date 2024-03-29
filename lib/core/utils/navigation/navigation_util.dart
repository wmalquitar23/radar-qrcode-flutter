import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/pages/navigation/navigation_page.dart';

import '../../../dependency_instantiator.dart';

void showNavigation(
  BuildContext context, {
  VoidCallback onMyProfile,
  VoidCallback onChangePIN,
  VoidCallback onContactUs,
  VoidCallback onLogout,
}) {
  showGeneralDialog(
    context: context,
    // ignore: missing_return
    pageBuilder: (context, _, __) {
      return BlocProvider(
        create: (_) => sl<NavigationBloc>(),
        child: NavigationPage(
          onMyProfile: onMyProfile,
          onChangePIN: onChangePIN,
          onContactUs: onContactUs,
          onLogout: onLogout,
        ),
      );
    },
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    barrierLabel: MaterialLocalizations.of(context).dialogLabel,
    transitionDuration: Duration(milliseconds: 300),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        transformHitTests: false,
        position: Tween<Offset>(
          begin: const Offset(0.0, -1.0),
          end: Offset.zero,
        ).animate(animation),
        child: new SlideTransition(
          position: new Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(0.0, 1.0),
          ).animate(secondaryAnimation),
          child: child,
        ),
      );
    },
  );
}

void showSlideUpDialog(BuildContext context, Widget child) {
  showGeneralDialog(
    context: context,
    // ignore: missing_return
    pageBuilder: (_, __, ___) {},
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.75),
    barrierLabel: '',
    transitionDuration: Duration(milliseconds: 300),
    transitionBuilder: (context, animation, secondaryAnimation, _) {
      return SlideTransition(
        transformHitTests: false,
        position: Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(animation),
        child: new SlideTransition(
          position: new Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(0.0, -1.0),
          ).animate(secondaryAnimation),
          child: child,
        ),
      );
    },
  );
}
