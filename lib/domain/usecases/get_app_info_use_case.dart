import 'package:package_info/package_info.dart';
import 'package:radar_qrcode_flutter/data/models/app_info.dart';

class GetAppInfoUseCase {
  Future<AppInfo> execute() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return AppInfo(
      appName: packageInfo.appName,
      packageName: packageInfo.packageName,
      version: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
    );
  }
}
