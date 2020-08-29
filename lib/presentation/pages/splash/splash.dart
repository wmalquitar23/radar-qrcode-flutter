import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/splash/splash_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/pages/splash/splash_page.dart';

import '../../../dependency_instantiator.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: buildBody(context)),
    );
  }

  Widget buildBody(context) {
    return BlocProvider(
      create: (_) => sl<SplashBloc>(),
      child: SplashPage(),
    );
  }
}
