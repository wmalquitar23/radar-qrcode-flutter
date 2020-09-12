import 'package:radar_qrcode_flutter/data/models/address/barangay_model.dart';
import 'package:radar_qrcode_flutter/data/models/address/city_model.dart';
import 'package:radar_qrcode_flutter/data/models/address/province_model.dart';
import 'package:radar_qrcode_flutter/domain/repositories/address_repository.dart';

class GetAddressUseCase {
  final AddressRepository repository;

  GetAddressUseCase(this.repository);

  Future<List<Province>> province() async {
    final provinceList = await repository.getAllProvince();
    provinceList.sort(
        (a, b) => a.provDesc.toLowerCase().compareTo(b.provDesc.toLowerCase()));
    return provinceList;
  }

  Future<List<City>> city() async {
    final cityList = await repository.getAllCityOrMunicipality();
    cityList.sort((a, b) =>
        a.citymunDesc.toLowerCase().compareTo(b.citymunDesc.toLowerCase()));
    return cityList;
  }

  Future<List<Barangay>> barangay() async {
    final barangay = await repository.getAllBarangay();
    barangay.sort(
        (a, b) => a.brgyDesc.toLowerCase().compareTo(b.brgyDesc.toLowerCase()));
    return barangay;
  }
}
