import 'package:radar_qrcode_flutter/data/mappers/user_address_mapper.dart';
import 'package:radar_qrcode_flutter/data/models/address/user_address_model.dart';

class RegisterEstablishmentRequest {
  String firstname;
  String pin;
  String contactNumber;
  UserAddress userAddress;
  String email;
  String designatedArea;
  String role;

  UserAddressMapper _userAddressMapper = UserAddressMapper();

  RegisterEstablishmentRequest({
    this.firstname,
    this.pin,
    this.contactNumber,
    this.userAddress,
    this.email,
    this.designatedArea,
  });

  RegisterEstablishmentRequest.fromJson(Map<String, dynamic> json) {
    firstname = json['firstName'];
    pin = json['pin'];
    contactNumber = json['contactNumber'];
    if (email != null) {
      email = json['email'];
    }
    role = json['role'];
    designatedArea = json['designatedArea'];
    userAddress = json['address'] != null
        ? _userAddressMapper.fromMap(json['address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstname;
    data['pin'] = this.pin;
    data['contactNumber'] = this.contactNumber;
    if (data['email'] != null) {
      data['email'] = this.email;
    }
    data['designatedArea'] = this.designatedArea;
    data['role'] = this.role;
    if (this.userAddress != null) {
      data['address'] = _userAddressMapper.toMap(this.userAddress);
    }
    return data;
  }
}
