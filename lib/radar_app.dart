import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/presentation/pages/errors/not_found_page.dart';
import './core/utils/routes/routes_navigation_util.dart' as routes;
import 'core/utils/color_util.dart';
import 'presentation/pages/splash/splash_page.dart';

class RadarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline6: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          headline5: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 14,
          ),
          subtitle1: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 12,
          ),
          subtitle2: TextStyle(
            color: ColorUtil.primaryTextColor,
            fontFamily: "Montserrat",
            fontSize: 13,
          ),
          bodyText1: TextStyle(
            color: ColorUtil.primaryTextColor,
            fontFamily: "Montserrat",
            fontSize: 10,
          ),
          bodyText2: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 11,
          ),
          button: TextStyle(
            fontFamily: "Montserrat",
          ),
          headline4: TextStyle(
            color: ColorUtil.primaryTextColor,
            fontSize: 9,
            fontWeight: FontWeight.w500,
            fontFamily: "Montserrat",
          ),
          headline3: TextStyle(
            color: ColorUtil.primaryTextColor,
            fontSize: 9,
            fontWeight: FontWeight.w500,
            fontFamily: "Montserrat",
          ),
        ),
      ),
      home: SplashPage(),
      onGenerateRoute: routes.generateRoute,
      onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => NotFoundPage(name: settings.name)),
    );
  }
}
