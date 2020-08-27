class RegisterEstablishmentRequest {
  String name;
  String pin;
  String contactNumber;
  Address address;

  RegisterEstablishmentRequest({
    this.name,
    this.pin,
    this.contactNumber,
    this.address
  });

  RegisterEstablishmentRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    pin = json['pin'];
    contactNumber = json['contactNumber'];
    address = json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['pin'] = this.pin;
    data['contactNumber'] = this.contactNumber;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    return data;
  }
}

class Address {
  String name;

  Address({this.name});

  Address.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}