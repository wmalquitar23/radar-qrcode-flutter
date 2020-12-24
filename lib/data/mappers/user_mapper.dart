import 'package:radar_qrcode_flutter/core/architecture/radar_app_architecture.dart';
import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:radar_qrcode_flutter/data/mappers/requirement_mapper.dart';
import 'package:radar_qrcode_flutter/data/mappers/user_address_mapper.dart';
import 'package:radar_qrcode_flutter/data/mappers/verification_mapper.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:intl/intl.dart';

class UserMapper extends RadarMapper<User> {
  DateFormat dateFormatter = DateFormat("yyyy-MM-dd");
  UserAddressMapper userAddressMapper = UserAddressMapper();
  RequirementMapper requirementMapper = RequirementMapper();
  VerificationMapper verificationMapper = VerificationMapper();
  @override
  User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Gender gender;
    if (map['gender'] != null) {
      switch (map['gender']?.toLowerCase()) {
        case 'male':
          gender = Gender.male;
          break;
        case 'female':
          gender = Gender.female;
          break;
        default:
      }
    }
    return User(
      id: map['_id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      middleName: map['middleName'] != null ? map['middleName'] : "",
      suffix: map['suffix'] != null ? map['suffix'] : "",
      birthDate: map['birthDate'] != null
          ? dateFormatter.parse(map['birthDate'])
          : null,
      gender: gender != null ? gender : null,
      contactNumber: map['contactNumber'],
      address: userAddressMapper.fromMap(map['address']),
      email: map['email'] != null ? map['email'] : "",
      covidStatus: map.containsKey("covidStatus")
          ? map['covidStatus']['category']
          : null,
      role: map['role'],
      isVerified: map.containsKey("verification")
          ? map['verification']['isVerified']
          : null,
      verification: verificationMapper.fromMap(map['verification']),
      profileImageUrl:
          map['profileImageFileId'] != null ? map['profileImageFileId'] : null,
      displayId: map['displayId'],
      establishmentName: map['firstName'],
      designatedArea:
          map['designatedArea'] != null ? map['designatedArea'] : null,
      requirement: requirementMapper.fromMap(map['requirementDoc']),
      createdAt: map.containsKey("createdAt")
          ? dateFormatter.parse(map['createdAt'])
          : null,
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
      "birthDate":
          object.birthDate != null ? object.birthDate.toIso8601String() : null,
      "profileImageFileId": object.profileImageUrl,
      "isVerified": object.isVerified,
      "role": object.role,
      "gender": object.gender,
      "contactNumber": object.contactNumber,
      "address": userAddressMapper.toMap(object.address),
      "designatedArea": object.designatedArea != null ? object.designatedArea : null,
    };
  }
}
