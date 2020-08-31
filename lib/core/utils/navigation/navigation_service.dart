import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_navigation_util.dart';

class NavigatorService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> pushNamed(String routeName, {Object arguments}) {
    return navigatorKey.currentState
        .pushNamed<dynamic>(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    Object arguments,
  }) {
    final RouteSettings settings =
        RouteSettings(name: routeName, arguments: arguments);
    return navigatorKey.currentState.pushAndRemoveUntil(
      generateRoute(settings),
      (Route<dynamic> route) => false,
    );
  }

  Future<dynamic> pushReplacement(String routeName, {Object arguments}) {
    final RouteSettings settings = RouteSettings(
      name: routeName,
      arguments: arguments,
    );
    return navigatorKey.currentState.pushReplacement(
      generateRoute(settings),
      result: arguments,
    );
  }

  void pop([dynamic results]) {
    return navigatorKey.currentState.pop<dynamic>(results);
  }
}
