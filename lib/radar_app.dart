import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/presentation/pages/errors/not_found_page.dart';
import './core/utils/routes/routes_navigation_util.dart' as routes;
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
      ),
      home: SplashPage(),
      onGenerateRoute: routes.generateRoute,
      onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => NotFoundPage(name: settings.name)),
    );
  }
}
