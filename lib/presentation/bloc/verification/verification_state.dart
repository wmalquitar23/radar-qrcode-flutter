part of 'verification_bloc.dart';

abstract class VerificationState extends Equatable {
  const VerificationState();
  
  @override
  List<Object> get props => [];
}

class VerificationInitial extends VerificationState {}
