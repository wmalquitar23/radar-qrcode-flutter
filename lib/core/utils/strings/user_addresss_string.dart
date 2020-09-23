import 'package:radar_qrcode_flutter/data/models/address/user_address_model.dart';

class UserAddressString {
  static String getValue(UserAddress userAddress) {
    final addressString = userAddress != null
        ? "${userAddress.brgyName}, ${userAddress.citymunName}, ${userAddress.provName}".toUpperCase()
        : "Data Not Available!";

    return addressString;
  }
}
