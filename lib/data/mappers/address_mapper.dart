import 'package:radar_qrcode_flutter/core/architecture/radar_app_architecture.dart';
import 'package:radar_qrcode_flutter/data/models/address/barangay_model.dart';
import 'package:radar_qrcode_flutter/data/models/address/city_model.dart';
import 'package:radar_qrcode_flutter/data/models/address/province_model.dart';

class AddressMapper {
  BarangayMapper barangayMapper = BarangayMapper();
  CityMapper cityMapper = CityMapper();
  ProvinceMapper provinceMapper = ProvinceMapper();
}

class BarangayMapper extends RadarMapper<Barangay> {

  @override
  fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return Barangay(
      id: map['id'],
      brgyCode: map['brgyCode'],
      brgyDesc: map['brgyDesc'],
      regCode: map['regCode'],
      provCode: map['provCode'],
      citymunCode: map['citymunCode'],
    );
  }

  @override
  List<Barangay> fromListMap(List listMap) {
    return super.fromListMap(listMap);
  }

  @override
  Map<String, dynamic> toMap(Barangay barangay) {
    return {
      "id": barangay.id,
      "brgyCode": barangay.brgyCode,
      "brgyDesc": barangay.brgyDesc,
      "regCode": barangay.regCode,
      "provCode": barangay.provCode,
      "citymunCode": barangay.citymunCode,
    };
  }
}

class CityMapper extends RadarMapper<City> {

  @override
  fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return City(
      id: map['id'],
      psgcCode: map['psgcCode'],
      citymunDesc: map['citymunDesc'],
      regDesc: map['regDesc'],
      provCode: map['provCode'],
      citymunCode: map['citymunCode'],
    );
  }

  @override
  List<City> fromListMap(List listMap) {
    return super.fromListMap(listMap);
  }

  @override
  Map<String, dynamic> toMap(City city) {
    return {
      "id": city.id,
      "psgcCode": city.psgcCode,
      "citymunDesc": city.citymunDesc,
      "regDesc": city.regDesc,
      "provCode": city.provCode,
      "citymunCode": city.citymunCode,
    };
  }
}

class ProvinceMapper extends RadarMapper<Province> {

  @override
  fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return Province(
      id: map['id'],
      psgcCode: map['psgcCode'],
      provDesc: map['provDesc'],
      regCode: map['regCode'],
      provCode: map['provCode'],
    );
  }

  @override
  List<Province> fromListMap(List listMap) {
    return super.fromListMap(listMap);
  }

  @override
  Map<String, dynamic> toMap(Province province) {
    return {
      "id": province.id,
      "psgcCode": province.psgcCode,
      "provDesc": province.provDesc,
      "regCode": province.regCode,
      "provCode": province.provCode,
    };
  }
}