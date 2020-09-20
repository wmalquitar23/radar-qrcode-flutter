part of 'address_picker_bloc.dart';

abstract class AddressPickerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddressPickerOnInitialLoad extends AddressPickerEvent {
  final AddressType addressType;
  final String filter;

  AddressPickerOnInitialLoad(
      {@required this.addressType, @required this.filter});

  @override
  List<Object> get props => [addressType, filter];
}

class AddressPickerSearch extends AddressPickerEvent {}
