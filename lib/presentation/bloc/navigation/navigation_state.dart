part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class NavigationInitial extends NavigationState {}

class NavigationLogoutSuccess extends NavigationState {}

class NavigationIdle extends NavigationState {}

class NavigationCheckUserRole extends NavigationState {
  
  final bool isIndividual;
  final bool hasLocalData;

  NavigationCheckUserRole(this.isIndividual, this.hasLocalData); 
}
