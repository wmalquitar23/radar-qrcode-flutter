import 'package:meta/meta.dart';
import 'package:radar_qrcode_flutter/data/models/address/address_model.dart';

class Province extends Address {
  final int id;
  final String psgcCode;
  final String provDesc;
  final String regCode;
  final String provCode;

  Province({
    @required this.id,
    @required this.psgcCode,
    @required this.provDesc,
    @required this.regCode,
    @required this.provCode,
  });
}

