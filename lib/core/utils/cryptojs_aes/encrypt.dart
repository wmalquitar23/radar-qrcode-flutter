import 'dart:convert';
import 'package:radar_qrcode_flutter/data/mappers/user_address_mapper.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';

String qrCodeObject(User user) {
  return jsonEncode({
    "_id": user.id,
    "displayId": user.displayId,
    "firstname": user.firstName,
    "lastname": user.lastName,
    "isVerified": user.isVerified,
    "profileImageUrl": user.profileImageUrl,
    "address": UserAddressMapper().toMap(user.address),
    "birthDate": user.birthDateToString(user.birthDate),
  });
}
