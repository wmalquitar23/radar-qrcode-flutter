import 'package:radar_qrcode_flutter/core/architecture/radar_app_architecture.dart';

class Requirement extends RadarModel {
  final bool isSubmitted;
  final String id;

  Requirement({
    this.isSubmitted,
    this.id,
  });
}
