part of 'estab_activation_info_bloc.dart';

abstract class EstabActivationInfoEvent extends Equatable {
  const EstabActivationInfoEvent();

  @override
  List<Object> get props => [];
}

class EstablishmentInfoOnLoad extends EstabActivationInfoEvent {}
