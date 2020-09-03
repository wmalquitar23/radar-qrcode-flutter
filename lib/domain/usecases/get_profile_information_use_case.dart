
import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:radar_qrcode_flutter/domain/repositories/profile_repository.dart';

class GetProfileInformationUseCase {
  final ProfileRepository repository;

  GetProfileInformationUseCase(this.repository);

  Future<Session> execute() async {
    return await repository.fetchUserInfo();
  }
}
