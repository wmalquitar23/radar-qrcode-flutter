import 'dart:convert';
import 'package:radar_qrcode_flutter/data/mappers/user_address_mapper.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';

String qrCodeObject(User user) {
  return jsonEncode({
    "_id": user.id,
    "role": user.role,
    "designatedArea": user.designatedArea != null ? user.designatedArea : "",
    "displayId": user.displayId,
    "firstName": user.firstName,
    "middleName": user.middleName,
    "lastName": user.lastName,
    "suffix": user.suffix,
    "verification": {"isVerified": user.isVerified},
    "covidStatus": {"category": user.covidStatus},
    "profileImageFileId": user.profileImageUrl,
    "address": UserAddressMapper().toMap(user.address),
    "birthDate": user.birthDateToString(user.birthDate),
  });
}
