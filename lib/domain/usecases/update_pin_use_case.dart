import 'package:radar_qrcode_flutter/domain/repositories/profile_repository.dart';

class UpdatePINUseCase {
  final ProfileRepository repository;

  UpdatePINUseCase(this.repository);

  Future<void> execute(String oldPIN, String newPIN) async {
    return await repository.changePin(oldPIN, newPIN);
  }
}
