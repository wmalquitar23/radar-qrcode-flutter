part of 'estab_activation_info_bloc.dart';

abstract class EstabActivationInfoState extends Equatable {
  const EstabActivationInfoState();

  @override
  List<Object> get props => [];
}

class EstabActivationInfoInitial extends EstabActivationInfoState {}

class GetUserInformationSuccess extends EstabActivationInfoState {
  final User user;

  const GetUserInformationSuccess({
    this.user,
  });

  @override
  List<Object> get props => [user];
}

class GetUserInformationLoading extends EstabActivationInfoState {}

class GetUserInformationFailure extends EstabActivationInfoState {
  final String error;

  const GetUserInformationFailure({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => '{ $error }';
}
