part of 'splash_bloc.dart';

@immutable
class SplashState extends Equatable {
  SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashProgress extends SplashState {}

class AppHasSession extends SplashState {}

class AppHasNoSession extends SplashState {}

class SplashDone extends SplashState {}
