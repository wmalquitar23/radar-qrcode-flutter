part of 'establishment_details_bloc.dart';

abstract class EstablishmentDetailsEvent extends Equatable {
  const EstablishmentDetailsEvent();

  @override
  List<Object> get props => [];
}

class OnLoadUserDetail extends EstablishmentDetailsEvent {
  final dynamic userInformation;

  OnLoadUserDetail(this.userInformation);
}

class OnUserApprove extends EstablishmentDetailsEvent {
  final User user;
  final String accessLogType;
  final DateTime dateTime;

  OnUserApprove(this.user, this.accessLogType, this.dateTime);
}
