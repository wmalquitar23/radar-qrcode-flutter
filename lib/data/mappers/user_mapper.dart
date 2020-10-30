import 'package:radar_qrcode_flutter/core/architecture/radar_app_architecture.dart';
import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:radar_qrcode_flutter/data/mappers/requirement_mapper.dart';
import 'package:radar_qrcode_flutter/data/mappers/user_address_mapper.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:intl/intl.dart';

class UserMapper extends RadarMapper<User> {
  DateFormat birthDateFormatter = DateFormat("yyyy-MM-dd");
  UserAddressMapper userAddressMapper = UserAddressMapper();
  RequirementMapper requirementMapper = RequirementMapper();
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
      firstName: map['firstName'],
      lastName: map['lastName'],
      middleName: map['middleName'] != null ? map['middleName'] : "",
      suffix: map['suffix'] != null ? map['suffix'] : null,
      birthDate: map['birthDate'] != null
          ? birthDateFormatter.parse(map['birthDate'])
          : null,
      gender: gender,
      contactNumber: map['contactNumber'],
      address: userAddressMapper.fromMap(map['address']),
      email: map['email'] != null ? map['email'] : "",
      covidStatus: map.containsKey("covidStatus")
          ? map['covidStatus']['category']
          : null,
      role: map['role'],
      isVerified: map['verification']['isVerified'],
      profileImageUrl:
          map['profileImageFileId'] != null ? map['profileImageFileId'] : null,
      displayId: map['displayId'],
      establishmentName: map['firstName'],
      requirement: requirementMapper.fromMap(map['requirementDoc']),
    );
  }

  @override
  Map<String, dynamic> toMap(object) {
    return {
      "_id": object.id,
      "displayId": object.displayId,
      "firstName": object.firstName,
      "middleName": object.middleName,
      "lastName": object.lastName,
      "suffix": object.suffix,
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
