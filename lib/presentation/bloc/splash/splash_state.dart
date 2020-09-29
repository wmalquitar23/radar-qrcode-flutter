part of 'splash_bloc.dart';

@immutable
class SplashState extends Equatable {
  SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashProgress extends SplashState {}

class AppHasSession extends SplashState {
  final String route;

  AppHasSession(this.route);
}

class AppInformation extends SplashState {
  final AppInfo appInfo;

  AppInformation({this.appInfo});
}

class AppHasNoSession extends SplashState {}

class SplashDone extends SplashState {}
