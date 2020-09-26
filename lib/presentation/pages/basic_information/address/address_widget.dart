import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:radar_qrcode_flutter/core/utils/style/textfield_theme.dart';
import 'package:radar_qrcode_flutter/data/models/address/address_model.dart';
import 'package:radar_qrcode_flutter/data/models/address/barangay_model.dart';
import 'package:radar_qrcode_flutter/data/models/address/city_model.dart';
import 'package:radar_qrcode_flutter/data/models/address/province_model.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/properties/shadow_widget.dart';

class AddressWidget extends StatefulWidget {
  final Function(Province) selectProvinceCallback;
  final Function(City) selectCityCallback;
  final Function(Barangay) selectBarangayCallback;
  final Province previouslySelectedProvince;
  final City previouslySelectedCity;
  final Barangay previouslySelectedBarangay;

  AddressWidget({
    @required this.selectProvinceCallback,
    @required this.selectCityCallback,
    @required this.selectBarangayCallback,
    this.previouslySelectedProvince,
    this.previouslySelectedCity,
    this.previouslySelectedBarangay,
  });

  @override
  _AddressWidgetState createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _barangayController = TextEditingController();

  final double _textFieldMargin = 10.0;

  bool _enableCityField = false;
  bool _enableBarangayField = false;

  Province _selectedProvince;
  City _selectedCity;
  Barangay _selectedBarangay;

  Address _previousSelection;

  Future<Address> _gotoPicker(
      AddressType addressType, String parentCode) async {
    switch (addressType) {
      case AddressType.province:
        _previousSelection = _selectedProvince;
        break;
      case AddressType.city:
        _previousSelection = _selectedCity;
        break;
      case AddressType.barangay:
        _previousSelection = _selectedBarangay;
        break;
      default:
    }

    final selectedAddress = await Navigator.pushNamed(
      context,
      ADDRESS_PICKER_PAGE_ROUTE,
      arguments: {
        "addressType": addressType,
        "filter": parentCode,
        "previousSelection": _previousSelection,
      },
    );

    return selectedAddress as Address;
  }

  void _openProvincePicker(AddressType addressType) async {
    _selectedProvince = await _gotoPicker(addressType, "");

    _provinceController.text = _selectedProvince?.provDesc ?? "";

    setState(() {
      _enableCityField = _selectedProvince != null;

      if (_previousSelection != null &&
          _previousSelection.runtimeType == Province &&
          (_previousSelection as Province).provCode !=
              _selectedProvince.provCode) {
        _selectedCity = null;
        _selectedBarangay = null;
        _cityController.text = "";
        _barangayController.text = "";

        _enableBarangayField = false;
      }
    });

    widget.selectProvinceCallback(
      _selectedProvince,
    );
  }

  void _openCityPicker(AddressType addressType) async {
    _selectedCity = await _gotoPicker(addressType, _selectedProvince.provCode);

    _cityController.text = _selectedCity?.citymunDesc ?? "";
    setState(() {
      _enableBarangayField = _selectedCity != null;

      if (_previousSelection != null &&
          _previousSelection.runtimeType == City &&
          (_previousSelection as City).citymunCode !=
              _selectedCity.citymunCode) {
        _selectedBarangay = null;
        _barangayController.text = "";
      }
    });

    widget.selectCityCallback(
      _selectedCity,
    );
  }

  void _openBarangayPicker(AddressType addressType) async {
    _selectedBarangay =
        await _gotoPicker(addressType, _selectedCity.citymunCode);

    _barangayController.text = _selectedBarangay?.brgyDesc ?? "";

    widget.selectBarangayCallback(
      _selectedBarangay,
    );
  }

  @override
  void initState() {
    setState(() {
      _selectedProvince = widget.previouslySelectedProvince;
      _selectedCity = widget.previouslySelectedCity;
      _selectedBarangay = widget.previouslySelectedBarangay;

      _enableCityField = _selectedProvince != null;
      _enableBarangayField = _selectedCity != null;

      _provinceController.text = _selectedProvince?.provDesc ?? "";
      _cityController.text = _selectedCity?.citymunDesc ?? "";
      _barangayController.text = _selectedBarangay?.brgyDesc ?? "";
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildProvinceTextField(),
        _buildCityTextField(),
        _buildBarangayTextField(),
      ],
    );
  }

  Widget _buildProvinceTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: _textFieldMargin),
      child: ShadowWidget(
        child: TextFormField(
          controller: _provinceController,
          onTap: () => _openProvincePicker(AddressType.province),
          readOnly: true,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration:
              TextFieldTheme.textfieldInputDecoration(hintText: "Province"),
        ),
      ),
    );
  }

  Widget _buildCityTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: _textFieldMargin),
      child: ShadowWidget(
        child: TextFormField(
          controller: _cityController,
          onTap: () => _openCityPicker(AddressType.city),
          enabled: _enableCityField,
          readOnly: true,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration: TextFieldTheme.textfieldInputDecoration(
              hintText: "City/Municipality"),
        ),
      ),
    );
  }

  Widget _buildBarangayTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: _textFieldMargin),
      child: ShadowWidget(
        child: TextFormField(
          controller: _barangayController,
          onTap: () => _openBarangayPicker(AddressType.barangay),
          readOnly: true,
          enabled: _enableBarangayField,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          decoration:
              TextFieldTheme.textfieldInputDecoration(hintText: "Barangay"),
        ),
      ),
    );
  }
}
