import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:radar_qrcode_flutter/domain/repositories/authentication_repository.dart';

class ListenForSessionUseCase {
  final AuthenticationRepository repository;

  ListenForSessionUseCase(this.repository);

  Stream<Session> stream() {
    return repository.listenForSession();
  }
}
