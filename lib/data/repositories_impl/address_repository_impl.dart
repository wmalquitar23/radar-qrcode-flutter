import 'package:radar_qrcode_flutter/data/mappers/address_mapper.dart';
import 'package:radar_qrcode_flutter/data/models/address/barangay_model.dart';
import 'package:radar_qrcode_flutter/data/models/address/city_model.dart';
import 'package:radar_qrcode_flutter/data/models/address/province_model.dart';
import 'package:radar_qrcode_flutter/data/sources/local_data/local_data_client.dart';
import 'package:radar_qrcode_flutter/domain/repositories/address_repository.dart';

class AddressRepositoryImpl extends AddressRepository {
  LocalDataClient _localDataClient;
  AddressMapper _addressMapper;

  AddressRepositoryImpl() {
    _localDataClient = LocalDataClient();
    _addressMapper = AddressMapper();
  }

  Future<List<Province>> getAllProvince() async {
    final jsonData = await _localDataClient.getProvince();
    final provinceJsonList = jsonData["RECORDS"] as List;

    List<Province> provinces = _addressMapper.provinceMapper.fromListMap(provinceJsonList);

    return provinces;
  }

  Future<List<City>> getAllCityOrMunicipality() async {
    final jsonData = await _localDataClient.getCityOrMunicipality();
    final cityJsonList = jsonData["RECORDS"] as List;

    List<City> cities = _addressMapper.cityMapper.fromListMap(cityJsonList);

    return cities;
  }

  Future<List<Barangay>> getAllBarangay() async {
    final jsonData = await _localDataClient.getBarangay();
    final barangayJsonList = jsonData["RECORDS"] as List;

    List<Barangay> barangays = _addressMapper.barangayMapper.fromListMap(barangayJsonList);

    return barangays;
  }
}
