part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class OnLogout extends NavigationEvent {}

class OnNavigationLoad extends NavigationEvent {}
