part of 'change_pin_bloc.dart';

abstract class ChangePinEvent extends Equatable {
  const ChangePinEvent();

  @override
  List<Object> get props => [];
}

class OnSaveNewPIN extends ChangePinEvent {
  final String oldPIN;
  final String newPIN;
  final String confirmPIN;

  OnSaveNewPIN({this.oldPIN, this.newPIN, this.confirmPIN});
  
  @override
  List<Object> get props => [oldPIN, newPIN, confirmPIN];
}
