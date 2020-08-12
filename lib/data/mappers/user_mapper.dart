import 'package:radar_qrcode_flutter/core/architecture/freddy_app_architecture.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';

class UserMapper extends RadarMapper<User> {
  @override
  User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return User(
      id: map['id'] != null ? map['id'] : null,
      firstName: map['first_name'],
      lastName: map['last_name'],
    );
  }

  @override
  Map<String, dynamic> toMap(User object) {
    return null;
  }
}
