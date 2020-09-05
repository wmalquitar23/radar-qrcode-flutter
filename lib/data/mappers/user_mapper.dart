import 'package:radar_qrcode_flutter/core/architecture/freddy_app_architecture.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:intl/intl.dart';

class UserMapper extends RadarMapper<User> {
  DateFormat birthDateFormatter = DateFormat("yyyy-MM-dd");
  @override
  User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return User(
      id: map['_id'],
      firstName: map['firstname'],
      lastName: map['lastname'],
      middleName: map['middlename'] != null ? map['middlename'] : null,
      birthDate: map['birthDate'] != null
          ? birthDateFormatter.parse(map['birthDate'])
          : null,
      gender: map['gender'],
      contactNumber: map['contactNumber'],
      address: map['address']['name'],
      role: map['role'],
      isVerified: map['isVerified'],
      profileImageUrl: map['profileImageUrl'],
      displayId: map['displayId'],
      establishmentName: map['firstname'],
    );
  }

  @override
  Map<String, dynamic> toMap(object) {
    return {
      "firstname": object.firstName,
      "lastname": object.lastName,
      "pin": object.pin,
      "birthDate": object.birthDate.toIso8601String(),
      "gender": object.gender,
      "contactNumber": object.contactNumber,
      "address": {"name": object.address},
    };
  }
}
