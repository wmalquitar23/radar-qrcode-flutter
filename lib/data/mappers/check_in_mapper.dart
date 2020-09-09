import 'package:radar_qrcode_flutter/core/architecture/radar_app_architecture.dart';
import 'package:radar_qrcode_flutter/data/mappers/user_mapper.dart';
import 'package:radar_qrcode_flutter/data/models/check_in.dart';
import 'package:intl/intl.dart';

class CheckInMapper extends RadarMapper<CheckIn> {
  UserMapper userMapper = UserMapper();

  DateFormat birthDateFormatter = DateFormat("yyyy-MM-dd");

  @override
  fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return CheckIn(
      key: map['key'],
      user: map.containsKey("user") ? userMapper.fromMap(map['user']) : null,
      dateTime: map['dateTime'] != null
          ? birthDateFormatter.parse(map['dateTime'])
          : null,
      hasUploaded: map['hasUploaded'],
    );
  }

  @override
  Map<String, dynamic> toMap(object) {
    return null;
  }
}
