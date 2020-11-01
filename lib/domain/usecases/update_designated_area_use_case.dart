import 'package:radar_qrcode_flutter/domain/repositories/profile_repository.dart';

class UpdateDesignatedAreaUseCase {
  final ProfileRepository repository;

  UpdateDesignatedAreaUseCase(this.repository);

  Future<void> execute(String designatedArea) async {
    return await repository.updateDesignatedArea(designatedArea);
  }
}
