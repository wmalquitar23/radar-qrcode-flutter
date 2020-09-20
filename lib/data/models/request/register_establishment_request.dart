import 'package:radar_qrcode_flutter/data/mappers/user_address_mapper.dart';
import 'package:radar_qrcode_flutter/data/models/address/user_address_model.dart';

class RegisterEstablishmentRequest {
  String firstname;
  String pin;
  String contactNumber;
  UserAddress userAddress;

  UserAddressMapper _userAddressMapper = UserAddressMapper();

  RegisterEstablishmentRequest({
    this.firstname,
    this.pin,
    this.contactNumber,
    this.userAddress
  });

  RegisterEstablishmentRequest.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    pin = json['pin'];
    contactNumber = json['contactNumber'];
    userAddress = json['address'] != null ? _userAddressMapper.fromMap(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['pin'] = this.pin;
    data['contactNumber'] = this.contactNumber;
    if (this.userAddress != null) {
      data['address'] = _userAddressMapper.toMap(this.userAddress);
    }
    return data;
  }
}