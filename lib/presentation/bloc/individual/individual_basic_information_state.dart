part of 'individual_basic_information_bloc.dart';

abstract class IndividualBasicInformationState extends Equatable {
  const IndividualBasicInformationState();

  @override
  List<Object> get props => [];
}

class IndividualBasicInformationInitial
    extends IndividualBasicInformationState {}

class RegisterDone extends IndividualBasicInformationState {}

class RegisterProgress extends IndividualBasicInformationState {}

class RegisterFailure extends IndividualBasicInformationState {
  final String error;

  const RegisterFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => '{ $error }';
}
