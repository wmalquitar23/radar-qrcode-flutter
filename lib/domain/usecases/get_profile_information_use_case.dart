import 'dart:io';
import 'package:radar_qrcode_flutter/domain/repositories/profile_repository.dart';

class GetProfileInformationUseCase {
  final ProfileRepository repository;

  GetProfileInformationUseCase(this.repository);

  Future<void> execute(File file) async {
    return await repository.uploadProfileImage(file);
  }
}
