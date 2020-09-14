part of 'verification_id_bloc.dart';

abstract class VerificationIdState extends Equatable {
  const VerificationIdState();

  @override
  List<Object> get props => [];
}

class VerificationIdInitial extends VerificationIdState {}

class VerificationIdUploadingImageLoading extends VerificationIdState {}

class VerificationIdUploadingImageSuccess extends VerificationIdState {}

class VerificationIdUploadingImageFailure extends VerificationIdState {
  final String error;

  const VerificationIdUploadingImageFailure({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => '{ $error }';
}
