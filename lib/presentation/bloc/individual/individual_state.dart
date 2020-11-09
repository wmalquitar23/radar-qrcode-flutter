part of 'individual_bloc.dart';

class IndividualState extends Equatable {
  final bool individualGetuserProgress;
  final bool individualGetuserSuccess;
  final IndividualGetUserSuccess individualGetUserSuccess;
  final String individualGetuserSuccessMessage;
  final String individualGetuserFailureMessage;
  final bool syncDataProgress;
  final List<CheckIn> localCheckInData;
  final List<CheckIn> totalScannedCheckInData;
  final bool syncDataSuccess;
  final String syncDataFailureMessage;

  const IndividualState({
    this.individualGetuserProgress,
    this.individualGetuserSuccess,
    this.individualGetUserSuccess,
    this.individualGetuserSuccessMessage,
    this.individualGetuserFailureMessage,
    this.syncDataProgress = false,
    this.localCheckInData,
    this.totalScannedCheckInData,
    this.syncDataSuccess = false,
    this.syncDataFailureMessage,
  });

  @override
  List<Object> get props => [
        individualGetuserProgress,
        individualGetuserSuccess,
        individualGetUserSuccess,
        individualGetuserSuccessMessage,
        individualGetuserFailureMessage,
        syncDataProgress,
        localCheckInData,
        totalScannedCheckInData,
        syncDataSuccess,
        syncDataFailureMessage,
      ];

  factory IndividualState.copyWith(
    IndividualState state, {
    bool individualGetuserProgress,
    bool individualGetuserSuccess,
    IndividualGetUserSuccess individualGetUserSuccess,
    String individualGetuserSuccessMessage,
    String individualGetuserFailureMessage,
    bool syncDataProgress = false,
    List<CheckIn> localCheckInData,
    List<CheckIn> totalScannedCheckInData,
    bool syncDataSuccess = false,
    String syncDataFailureMessage,
  }) {
    return IndividualState(
      individualGetuserProgress:
          individualGetuserProgress ?? state.individualGetuserProgress,
      individualGetuserSuccess:
          individualGetuserSuccess ?? state.individualGetuserSuccess,
      individualGetUserSuccess:
          individualGetUserSuccess ?? state.individualGetUserSuccess,
      individualGetuserSuccessMessage: individualGetuserSuccessMessage ?? null,
      individualGetuserFailureMessage: individualGetuserFailureMessage ?? null,
      syncDataProgress: syncDataProgress ?? state.syncDataProgress,
      localCheckInData: localCheckInData ?? state.localCheckInData,
      totalScannedCheckInData:
          totalScannedCheckInData ?? state.totalScannedCheckInData,
      syncDataSuccess: syncDataSuccess ?? state.syncDataSuccess,
      syncDataFailureMessage: syncDataFailureMessage ?? null,
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
