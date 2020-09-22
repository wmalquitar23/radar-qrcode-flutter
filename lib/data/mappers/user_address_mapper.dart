import 'package:radar_qrcode_flutter/core/architecture/radar_app_architecture.dart';
import 'package:radar_qrcode_flutter/data/models/address/user_address_model.dart';

class UserAddressMapper extends RadarMapper<UserAddress> {
  @override
  fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return UserAddress(
      brgyCode: map['brgyCode'],
      brgyName: map['brgyName'],
      citymunCode: map['citymunCode'],
      citymunName: map['citymunName'],
      provCode: map['provCode'],
      provName: map['provName'],
      streetHouseNo: map['streetHouseNo'],
    );
  }

  @override
  Map<String, dynamic> toMap(UserAddress userAddress) {
    return {
      "brgyCode": userAddress.brgyCode,
      "brgyName": userAddress.brgyName,
      "citymunCode": userAddress.citymunCode,
      "citymunName": userAddress.citymunName,
      "provCode": userAddress.provCode,
      "provName": userAddress.provName,
      "streetHouseNo": userAddress.streetHouseNo,
    };
  }
}
