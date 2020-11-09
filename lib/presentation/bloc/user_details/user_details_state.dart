part of 'user_details_bloc.dart';

class UserDetailsState extends Equatable {
  final User userInformation;
  final bool userLoadSuccess;
  final bool userApproveLoading;
  final bool userApproveFailure;
  final bool userApproveDone;

  UserDetailsState({
    this.userInformation,
    this.userLoadSuccess = false,
    this.userApproveLoading = false,
    this.userApproveFailure = false,
    this.userApproveDone = false,
  });

  @override
  List<Object> get props => [
        userInformation,
        userLoadSuccess,
        userApproveLoading,
        userApproveFailure,
        userApproveDone,
      ];

  factory UserDetailsState.copyWith(
    UserDetailsState state, {
    User userInformation,
    bool userLoadSuccess,
    bool userApproveLoading,
    bool userApproveFailure,
    bool userApproveDone,
  }) {
    return UserDetailsState(
      userInformation: userInformation ?? state.userInformation,
      userLoadSuccess: userLoadSuccess ?? state.userLoadSuccess,
      userApproveLoading: userApproveLoading ?? state.userApproveLoading,
      userApproveFailure: userApproveFailure ?? state.userApproveFailure,
      userApproveDone: userApproveDone ?? state.userApproveDone,
    );
  }
}

class UserDetailsInitial extends UserDetailsState {}

class UserDetailLoadSuccess extends UserDetailsState {
  final User userInformation;

  UserDetailLoadSuccess(this.userInformation);
}

class UserDetailApproveLoading extends UserDetailsState {}

class UserDetailApproveFailure extends UserDetailsState {}

class UserDetailApproveDone extends UserDetailsState {}
