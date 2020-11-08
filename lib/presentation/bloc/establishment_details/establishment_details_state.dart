part of 'establishment_details_bloc.dart';

class EstablishmentDetailsState extends Equatable {
  final User establishmentInformation;
  final bool establishmentLoadSuccess;
  final bool establishmentApproveLoading;
  final bool establishmentApproveFailure;
  final bool establishmentApproveDone;
  final User getCurrentUser;
  final DateTime dateTime;

  EstablishmentDetailsState({
    this.establishmentInformation,
    this.establishmentLoadSuccess = false,
    this.establishmentApproveLoading = false,
    this.establishmentApproveFailure = false,
    this.establishmentApproveDone = false,
    this.getCurrentUser,
    this.dateTime,
  });
  @override
  List<Object> get props => [
        establishmentInformation,
        establishmentLoadSuccess,
        establishmentApproveLoading,
        establishmentApproveFailure,
        establishmentApproveDone,
        getCurrentUser,
        dateTime,
      ];

  factory EstablishmentDetailsState.copyWith(
    EstablishmentDetailsState state, {
    User establishmentInformation,
    bool establishmentLoadSuccess,
    bool establishmentApproveLoading,
    bool establishmentApproveFailure,
    bool establishmentApproveDone,
    User getCurrentUser,
    DateTime dateTime,
  }) {
    return EstablishmentDetailsState(
      establishmentInformation:
          establishmentInformation ?? state.establishmentInformation,
      establishmentLoadSuccess:
          establishmentLoadSuccess ?? state.establishmentLoadSuccess,
      establishmentApproveLoading:
          establishmentApproveLoading ?? state.establishmentApproveLoading,
      establishmentApproveFailure:
          establishmentApproveFailure ?? state.establishmentApproveFailure,
      establishmentApproveDone:
          establishmentApproveDone ?? state.establishmentApproveDone,
      getCurrentUser: getCurrentUser ?? state.getCurrentUser,
      dateTime: dateTime ?? state.dateTime,
    );
  }
}

class EstablishmentDetailsInitial extends EstablishmentDetailsState {}
