import 'package:radar_qrcode_flutter/core/architecture/radar_app_architecture.dart';
import 'package:radar_qrcode_flutter/data/mappers/user_mapper.dart';
import 'package:radar_qrcode_flutter/data/models/check_in.dart';

class CheckInMapper extends RadarMapper<CheckIn> {
  UserMapper userMapper = UserMapper();

  @override
  fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return CheckIn(
      key: map['key'],
      user: map.containsKey("user") ? userMapper.fromMap(map['user']) : null,
      dateTime: map['dateTime'] != null ? map['dateTime'] : null,
      hasUploaded: map['hasUploaded'],
      accessLogType: map['accessLogType'],
    );
  }

  @override
  Map<String, dynamic> toMap(object) {
    return null;
  }
}
