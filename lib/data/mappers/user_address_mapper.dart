import 'package:radar_qrcode_flutter/core/architecture/radar_app_architecture.dart';
import 'package:radar_qrcode_flutter/data/models/address/user_address_model.dart';

class UserAddressMapper extends RadarMapper<UserAddress> {
  @override
  fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return UserAddress(
      brgyCode: map['brgyCode'],
      citymunCode: map['citymunCode'],
      provCode: map['provCode'],
      streetHouseNo: map['streetHouseNo'],
    );
  }

  @override
  Map<String, dynamic> toMap(UserAddress userAddress) {
    return {
      "brgyCode": userAddress.brgyCode,
      "citymunCode": userAddress.citymunCode,
      "provCode": userAddress.provCode,
      "streetHouseNo": userAddress.streetHouseNo,
    };
  }
}
