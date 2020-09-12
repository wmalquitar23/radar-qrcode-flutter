import 'package:meta/meta.dart';
import 'package:radar_qrcode_flutter/data/models/address/address_model.dart';

class City extends Address {
  final int id;
  final String psgcCode;
  final String citymunDesc;
  final String regDesc;
  final String provCode;
  final String citymunCode;

  City({
    @required this.id,
    @required this.psgcCode,
    @required this.citymunDesc,
    @required this.regDesc,
    @required this.provCode,
    @required this.citymunCode,
  });
}