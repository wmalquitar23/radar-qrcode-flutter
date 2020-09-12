part of 'address_picker_bloc.dart';

abstract class AddressPickerEvent extends Equatable {}

class AddressPickerOnInitialLoad extends AddressPickerEvent {
  final AddressType addressType;
  final String filter;

  AddressPickerOnInitialLoad({@required this.addressType, @required this.filter});

  @override
  List<Object> get props => [addressType, filter];
}

class AddressPickerSearch extends AddressPickerEvent {
  final AddressType addressType;
  final String keyword;
  final String filter;

  AddressPickerSearch({@required this.addressType, @required this.filter, @required this.keyword});

  @override
  List<Object> get props => [addressType, filter, keyword];
}
