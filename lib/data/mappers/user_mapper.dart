import 'package:radar_qrcode_flutter/core/architecture/radar_app_architecture.dart';
import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:radar_qrcode_flutter/data/mappers/user_address_mapper.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:intl/intl.dart';

class UserMapper extends RadarMapper<User> {
  DateFormat birthDateFormatter = DateFormat("yyyy-MM-dd");
  UserAddressMapper userAddressMapper = UserAddressMapper();
  @override
  User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Gender gender;
    switch (map['gender']?.toLowerCase()) {
      case 'male':
        gender = Gender.male;
        break;
      case 'female':
        gender = Gender.female;
        break;
      default:
    }
    return User(
      id: map['_id'],
      firstName: map['firstname'],
      lastName: map['lastname'],
      middleName: map['middlename'] != null ? map['middlename'] : null,
      birthDate: map['birthDate'] != null
          ? birthDateFormatter.parse(map['birthDate'])
          : null,
      gender: gender,
      contactNumber: map['contactNumber'],
      address: userAddressMapper.fromMap(map['address']),
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
      "_id": object.id,
      "displayId": object.displayId,
      "firstname": object.firstName,
      "lastname": object.lastName,
      "pin": object.pin,
      "birthDate": object.birthDate.toIso8601String(),
      "profileImageUrl": object.profileImageUrl,
      "isVerified": object.isVerified,
      "role": object.role,
      "gender": object.gender,
      "contactNumber": object.contactNumber,
      "address": userAddressMapper.toMap(object.address),
    };
  }
}
