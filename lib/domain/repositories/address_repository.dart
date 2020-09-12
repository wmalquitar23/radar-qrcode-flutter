import 'package:radar_qrcode_flutter/data/models/address/barangay_model.dart';
import 'package:radar_qrcode_flutter/data/models/address/city_model.dart';
import 'package:radar_qrcode_flutter/data/models/address/province_model.dart';

abstract class AddressRepository {

  Future<List<Province>> getAllProvince();

  Future<List<City>> getAllCityOrMunicipality();

  Future<List<Barangay>> getAllBarangay();

}