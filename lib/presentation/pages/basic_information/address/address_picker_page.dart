import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:radar_qrcode_flutter/data/models/address/address_model.dart';
import 'package:radar_qrcode_flutter/data/models/address/barangay_model.dart';
import 'package:radar_qrcode_flutter/data/models/address/city_model.dart';
import 'package:radar_qrcode_flutter/data/models/address/province_model.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/address_picker/address_picker_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/widgets/properties/overscroll_glow_disabled_behavior.dart';

class AddressPickerPage extends StatefulWidget {
  final Map<String, dynamic> args;

  AddressPickerPage({@required this.args});

  @override
  _AddressPickerPageState createState() => _AddressPickerPageState();
}

class _AddressPickerPageState extends State<AddressPickerPage> {
  String _title;

  List<Address> _addressList;

  Address _previousSelection;

  AddressType _addressType;
  String _filter;

  @override
  void initState() {
    _addressType = widget.args["addressType"];
    _filter = widget.args["filter"];
    _previousSelection = widget.args["previousSelection"];

    String type = _addressType.toString().split(".")[1];
    _title = "Pick ${type[0].toUpperCase()}${type.substring(1)}";

    super.initState();
  }

  void _onLoadPage() {
    BlocProvider.of<AddressPickerBloc>(context).add(
      AddressPickerOnInitialLoad(
        addressType: _addressType,
        filter: _filter,
      ),
    );
  }

  void _setAddressList(List<Address> addrList) {
    switch (_addressType) {
      case AddressType.province:
        _addressList = addrList;
        break;
      case AddressType.city:
        _addressList = addrList;
        break;
      case AddressType.barangay:
        _addressList = addrList;
        break;
      default:
    }
  }

  void _searchAddress(String keyword) {
    BlocProvider.of<AddressPickerBloc>(context).add(
      AddressPickerSearch(
        addressType: _addressType,
        filter: _filter,
        keyword: keyword,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, _previousSelection);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: CloseButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context, _previousSelection);
            },
          ),
          title: Text(
            _title,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          elevation: 0.0,
        ),
        body: Container(
          child: _buildBody(),
        ),
      ),
    );
  }

  Column _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildSearchSection(),
        _buildContentSection(),
      ],
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 10,
      ),
      child: TextFormField(
        onChanged: (value) => _searchAddress(value),
        style: TextStyle(
          fontSize: 13,
        ),
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: Container(
            margin: EdgeInsets.only(left: 20, right: 14),
            child: Icon(
              Icons.search,
              color: Colors.black45,
              size: 20,
            ),
          ),
          suffixIcon: Icon(
            Icons.clear,
            color: Colors.black45,
            size: 20,
          ),
          hintText: "Search Location",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35.0),
            borderSide: BorderSide(
              color: Colors.black45,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35.0),
            borderSide: BorderSide(
              color: Colors.black45,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentSection() {
    return BlocBuilder<AddressPickerBloc, AddressPickerState>(
      builder: (context, state) {
        print(state.toString());

        if (state is AddressPickerInitial) {
          _onLoadPage();
          return _buildLoadingIndicator();
        }

        if (state is AddressPickerIsFetchingData ||
            state is AddressPickerIsSearching) {
          return _buildLoadingIndicator();
        }

        if (state is AddressPickerIsDoneFetching ||
            state is AddressPickerIsDoneSearching) {
          _setAddressList(state.addressList);
        }
        return Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ScrollConfiguration(
              behavior: OverScrollGlowDisabledBehavior(),
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey,
                  indent: 20,
                  endIndent: 20,
                ),
                itemCount: _addressList.length,
                itemBuilder: (context, index) {
                  return _buildListItem(_addressList[index]);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildListItem(Address address) {
    dynamic addressData;
    Function selectAddress;

    switch (_addressType) {
      case AddressType.province:
        Province province = address;
        addressData = {
          "id": province.id,
          "desc": province.provDesc,
          "isSelected":
              province.provCode == (_previousSelection as Province)?.provCode,
        };

        selectAddress = () {
          Navigator.pop(
            context,
            address,
          );
        };
        break;
      case AddressType.city:
        City city = address;
        addressData = {
          "id": city.id,
          "desc": city.citymunDesc,
          "isSelected":
              city.citymunCode == (_previousSelection as City)?.citymunCode,
        };

        selectAddress = () {
          Navigator.pop(
            context,
            city,
          );
        };

        selectAddress = () {
          Navigator.pop(
            context,
            city,
          );
        };
        break;
      case AddressType.barangay:
        Barangay barangay = address;
        addressData = {
          "id": barangay.id,
          "desc": barangay.brgyDesc,
          "isSelected":
              barangay.brgyCode == (_previousSelection as Barangay)?.brgyCode,
        };

        selectAddress = () {
          Navigator.pop(
            context,
            barangay,
          );
        };
        break;
      default:
    }

    return ListTile(
      key: ValueKey(addressData["id"]),
      leading: Icon(Icons.pin_drop),
      dense: true,
      title: Text(addressData["desc"]),
      onTap: selectAddress,
      selected: addressData["isSelected"],
    );
  }

  Widget _buildLoadingIndicator() {
    return Expanded(
      child: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
