import 'package:radar_qrcode_flutter/core/architecture/freddy_app_architecture.dart';
import 'package:radar_qrcode_flutter/data/mappers/user_mapper.dart';
import 'package:radar_qrcode_flutter/data/models/session_model.dart';

class SessionMapper extends RadarMapper<Session> {
  UserMapper userMapper = UserMapper();

  @override
  fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return Session(
      user: map.containsKey("user") ? userMapper.fromMap(map['user']) : null,
      token: map['profile'],
    );
  }

  @override
  Map<String, dynamic> toMap(object) {
    return null;
  }
}
