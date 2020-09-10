part of 'individual_bloc.dart';

class IndividualState extends Equatable {
  final bool individualGetuserProgress;
  final bool individualGetuserSuccess;
  final IndividualGetUserSuccess individualGetUserSuccess;
  final String individualGetuserSuccessMessage;
  final String individualGetuserFailureMessage;

  const IndividualState(
      {this.individualGetuserProgress,
      this.individualGetuserSuccess,
      this.individualGetUserSuccess,
      this.individualGetuserSuccessMessage,
      this.individualGetuserFailureMessage});

  @override
  List<Object> get props => [
        individualGetuserProgress,
        individualGetuserSuccess,
        individualGetUserSuccess,
        individualGetuserSuccessMessage,
        individualGetuserFailureMessage
      ];

  factory IndividualState.copyWith(
    IndividualState state, {
    bool individualGetuserProgress,
    bool individualGetuserSuccess,
    IndividualGetUserSuccess individualGetUserSuccess,
    String individualGetuserSuccessMessage,
    String individualGetuserFailureMessage,
  }) {
    return IndividualState(
      individualGetuserProgress:
          individualGetuserProgress ?? state.individualGetuserProgress,
      individualGetuserSuccess:
          individualGetuserSuccess ?? state.individualGetuserSuccess,
      individualGetUserSuccess:
          individualGetUserSuccess ?? state.individualGetUserSuccess,
      individualGetuserSuccessMessage:
          individualGetuserSuccessMessage ?? null,
      individualGetuserFailureMessage:
          individualGetuserFailureMessage ?? null,
    );
  }
}

class IndividualInitial extends IndividualState {}

class IndividualGetUserSuccess extends IndividualState {
  final User user;
  final String jsonQrCode;

  const IndividualGetUserSuccess({this.user, this.jsonQrCode});

  @override
  List<Object> get props => [user, jsonQrCode];
}
