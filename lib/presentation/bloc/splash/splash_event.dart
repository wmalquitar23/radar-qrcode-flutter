part of 'splash_bloc.dart';

@immutable
abstract class SplashEvent {}

class GetSession extends SplashEvent {}

class OnGetAppInfo extends SplashEvent {}
