part of 'establishment_bloc.dart';

class EstablishmentState extends Equatable {
  final bool establishmentGetUserProgress;
  final User user;
  final bool establishmentGetUserFailure;
  final bool profileUploadImageProgress;
  final bool profileUploadImageSuccess;
  final String profileUploadImageFailureMessage;
  final bool syncDataProgress;
  final List<CheckIn> localCheckInData;
  final bool syncDataSuccess;
  final String syncDataFailureMessage;
  final String establishementGetUserSuccessMessage;

  EstablishmentState({
    this.establishmentGetUserProgress,
    this.user,
    this.establishmentGetUserFailure,
    this.profileUploadImageProgress,
    this.profileUploadImageSuccess,
    this.profileUploadImageFailureMessage,
    this.syncDataProgress,
    this.localCheckInData,
    this.syncDataSuccess,
    this.syncDataFailureMessage,
    this.establishementGetUserSuccessMessage,
  });

  @override
  List<Object> get props => [
        establishmentGetUserProgress,
        user,
        establishmentGetUserFailure,
        profileUploadImageProgress,
        profileUploadImageSuccess,
        profileUploadImageFailureMessage,
        syncDataProgress,
        localCheckInData,
        syncDataSuccess,
        syncDataFailureMessage,
        establishementGetUserSuccessMessage,
      ];

  factory EstablishmentState.copyWith(
    EstablishmentState state, {
    bool establishmentGetUserProgress = false,
    User user,
    bool establishmentGetUserFailure = false,
    bool profileUploadImageProgress = false,
    bool profileUploadImageSuccess = false,
    String profileUploadImageFailureMessage,
    bool syncDataProgress = false,
    List<CheckIn> localCheckInData,
    bool syncDataSuccess = false,
    String syncDataFailureMessage,
    String establishementGetUserSuccessMessage,
  }) {
    return EstablishmentState(
      establishmentGetUserProgress:
          establishmentGetUserProgress ?? state.establishmentGetUserProgress,
      user: user ?? state.user,
      establishmentGetUserFailure:
          establishmentGetUserFailure ?? state.establishmentGetUserFailure,
      profileUploadImageProgress:
          profileUploadImageProgress ?? state.profileUploadImageProgress,
      profileUploadImageSuccess:
          profileUploadImageSuccess ?? state.profileUploadImageSuccess,
      profileUploadImageFailureMessage: profileUploadImageFailureMessage ??
          state.profileUploadImageFailureMessage,
      syncDataProgress: syncDataProgress ?? state.syncDataProgress,
      localCheckInData: localCheckInData ?? state.localCheckInData,
      syncDataSuccess: syncDataSuccess ?? state.syncDataSuccess,
      syncDataFailureMessage: syncDataFailureMessage ?? null,
      establishementGetUserSuccessMessage: establishementGetUserSuccessMessage ?? null
    );
  }
}

class EstablishmentInitial extends EstablishmentState {}
