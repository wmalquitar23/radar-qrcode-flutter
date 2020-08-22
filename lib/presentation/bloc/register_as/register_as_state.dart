part of 'register_as_bloc.dart';

abstract class RegisterAsState extends Equatable {
  const RegisterAsState();

  @override
  List<Object> get props => [];
}

class RegisterAsInitial extends RegisterAsState {}

class SelectIndividual extends RegisterAsState {}

class SelectEstablishment extends RegisterAsState {}
