import 'package:radar_qrcode_flutter/data/mappers/user_address_mapper.dart';
import 'package:radar_qrcode_flutter/data/models/address/user_address_model.dart';

class RegisterIndividualRequest {
  String firstname;
  String middlename;
  String lastname;
  String pin;
  String birthDate;
  String gender;
  String contactNumber;
  UserAddress userAddress;

  UserAddressMapper _userAddressMapper = UserAddressMapper();

  RegisterIndividualRequest(
      {this.firstname,
      this.middlename,
      this.lastname,
      this.pin,
      this.birthDate,
      this.gender,
      this.contactNumber,
      this.userAddress});

  RegisterIndividualRequest.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    middlename = json['middlename'];
    lastname = json['lastname'];
    pin = json['pin'];
    birthDate = json['birthDate'];
    gender = json['gender'];
    contactNumber = json['contactNumber'];
    userAddress = json['address'] != null
        ? _userAddressMapper.fromMap(json['address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['middlename'] = this.middlename;
    data['lastname'] = this.lastname;
    data['pin'] = this.pin;
    data['birthDate'] = this.birthDate;
    data['gender'] = this.gender;
    data['contactNumber'] = this.contactNumber;
    if (this.userAddress != null) {
      data['address'] = _userAddressMapper.toMap(this.userAddress);
    }
    return data;
  }
}