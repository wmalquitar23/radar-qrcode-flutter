import 'package:meta/meta.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:radar_qrcode_flutter/data/models/address/address_model.dart';
import 'package:radar_qrcode_flutter/data/models/address/barangay_model.dart';
import 'package:radar_qrcode_flutter/data/models/address/city_model.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_address_use_case.dart';

part 'address_picker_event.dart';
part 'address_picker_state.dart';

class AddressPickerBloc extends Bloc<AddressPickerEvent, AddressPickerState> {
  final GetAddressUseCase getAddressUseCase;
  AddressPickerBloc({this.getAddressUseCase}) : super(AddressPickerInitial());

  @override
  Stream<AddressPickerState> mapEventToState(AddressPickerEvent event) async* {
    if (event is AddressPickerOnInitialLoad) {
      yield AddressPickerIsFetchingData();

      List<Address> addressList;

      switch (event.addressType) {
        case AddressType.province:
          addressList = await this.getAddressUseCase.province();
          break;
        case AddressType.city:
          addressList = await this.getAddressUseCase.city();
          addressList = addressList
              .where((addr) => (addr as City).provCode == event.filter)
              .cast<Address>()
              .toList();
          break;
        case AddressType.barangay:
          addressList = await this.getAddressUseCase.barangay();
          addressList = addressList
              .where((addr) => (addr as Barangay).citymunCode == event.filter)
              .cast<Address>()
              .toList();
          break;
        default:
      }

      yield AddressPickerIsFetchingData();

      yield AddressPickerIsDoneFetching(addressList: addressList);
    } else if (event is AddressPickerSearch) {
      yield AddressPickerIsSearching();
    }
  }
}
