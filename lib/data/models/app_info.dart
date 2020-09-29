import 'package:radar_qrcode_flutter/core/architecture/radar_app_architecture.dart';

class AppInfo extends RadarModel {
  final String appName;
  final String packageName;
  final String version;
  final String buildNumber;

  AppInfo({this.appName, this.packageName, this.version, this.buildNumber});
}
