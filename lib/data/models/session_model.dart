import 'package:radar_qrcode_flutter/core/architecture/freddy_app_architecture.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';

class Session extends RadarModel {
  final User user;
  final String token;

  Session({this.user, this.token});
}
