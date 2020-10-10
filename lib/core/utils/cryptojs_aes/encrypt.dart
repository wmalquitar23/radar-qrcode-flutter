import 'dart:convert';
import 'package:radar_qrcode_flutter/data/mappers/user_address_mapper.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';

String qrCodeObject(User user) {
  return jsonEncode({
    "_id": user.id,
    "role": user.role,
    "displayId": user.displayId,
    "firstname": user.firstName,
    "middlename": user.middleName,
    "lastname": user.lastName,
    "suffix": user.suffix,
    "isVerified": user.isVerified,
    "profileImageUrl": user.profileImageUrl,
    "address": UserAddressMapper().toMap(user.address),
    "birthDate": user.birthDate != null ? user.birthDateToString(user.birthDate) : "",
  });
}
