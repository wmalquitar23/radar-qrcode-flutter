import 'package:radar_qrcode_flutter/domain/repositories/authentication_repository.dart';

class LogoutUseCase {
  final AuthenticationRepository repository;

  LogoutUseCase(this.repository);

  Future<void> execute() async {
    return await repository.logout();
  }
}
