import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:radar_qrcode_flutter/domain/repositories/authentication_repository.dart';

class GetSessionUseCase {
  final AuthenticationRepository repository;

  GetSessionUseCase(this.repository);

  Future<Session> execute() async {
    return await repository.getCurrentSession();
  }
}
