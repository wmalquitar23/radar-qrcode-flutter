import 'package:radar_qrcode_flutter/domain/repositories/authentication_repository.dart';

class SignInUseCase {
  SignInUseCase(this.repository);

  final AuthenticationRepository repository;

  Future<void> execute(String contactNumber, String pin) async {
    await repository.signIn(contactNumber, pin);
  }
}
