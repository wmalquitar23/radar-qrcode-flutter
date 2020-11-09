import 'package:radar_qrcode_flutter/core/architecture/radar_app_architecture.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';

class CheckIn extends RadarModel {
  final int key;
  final User user;
  final String dateTime;
  final bool hasUploaded;
  final String accessLogType;

  CheckIn({
    this.key,
    this.user,
    this.dateTime,
    this.hasUploaded,
    this.accessLogType,
  });
}
