part of 'register_as_bloc.dart';

abstract class RegisterAsEvent extends Equatable {
  const RegisterAsEvent();

  @override
  List<Object> get props => [];
}

class OnSelectRegistrationType extends RegisterAsEvent{
  final SelectedRegistrationType selectedRegistrationType;

  OnSelectRegistrationType({this.selectedRegistrationType});
}