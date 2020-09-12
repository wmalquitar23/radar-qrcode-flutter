import 'package:meta/meta.dart';
import 'package:radar_qrcode_flutter/data/models/address/address_model.dart';

class Barangay extends Address {
  final int id;
  final String brgyCode;
  final String brgyDesc;
  final String regCode;
  final String provCode;
  final String citymunCode;

  Barangay({
    @required this.id,
    @required this.brgyCode,
    @required this.brgyDesc,
    @required this.regCode,
    @required this.provCode,
    @required this.citymunCode,
  });
}