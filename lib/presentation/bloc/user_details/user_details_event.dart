part of 'user_details_bloc.dart';

abstract class UserDetailsEvent extends Equatable {
  const UserDetailsEvent();

  @override
  List<Object> get props => [];
}

class OnLoadUserDetail extends UserDetailsEvent {
  final dynamic userInformation;

  OnLoadUserDetail(this.userInformation);
}

class OnUserApprove extends UserDetailsEvent {
  final User user;

  OnUserApprove(this.user);
}
