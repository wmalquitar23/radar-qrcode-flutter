part of 'address_picker_bloc.dart';

abstract class AddressPickerState extends Equatable {
  final List<Address> addressList;
  final bool isFetchingData;
  final bool isDoneFetching;
  final bool isFetchingFailed;
  final bool isSearching;
  final bool isDoneSearching;

  AddressPickerState({
    this.addressList,
    this.isFetchingData,
    this.isDoneFetching,
    this.isFetchingFailed,
    this.isSearching,
    this.isDoneSearching,
  });

  @override
  List<Object> get props => [
        addressList,
        isFetchingData,
        isDoneFetching,
        isFetchingFailed,
        isSearching,
        isDoneSearching,
      ];
}

class AddressPickerInitial extends AddressPickerState {}

class AddressPickerIsFetchingData extends AddressPickerState {
  final bool isFetchingData;

  AddressPickerIsFetchingData({this.isFetchingData = true})
      : super(isFetchingData: isFetchingData);
}

class AddressPickerIsDoneFetching extends AddressPickerState {
  final bool isDoneFetching;
  final List<Address> addressList;

  AddressPickerIsDoneFetching({
    this.isDoneFetching = true,
    @required this.addressList,
  }) : super(
          addressList: addressList,
          isDoneFetching: isDoneFetching,
        );
}

class AddressPickerIsSearching extends AddressPickerState {}
